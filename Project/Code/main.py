import pyodbc
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from schema import URL_table
import uvicorn
import secrets
import string
from datetime import date, timedelta

# Global variable to store the connection
conn = None
counter = 0

# FastAPI server instance
app = FastAPI()

# Set up the connection details
server = 'NYX'
database = 'Final'
username = 'project'
password = '9839039'
connection_string = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}'
# Global variable to store the connection
conn = None


def calculate_expire_date():
    today = date.today()
    expire_date = today + timedelta(days=7)
    return expire_date


# to generate shorten url
def generate_shorten_url():
    alphabet = string.ascii_lowercase + string.digits
    shorten_url = ''.join(secrets.choice(alphabet) for _ in range(6))
    return shorten_url


# Database functions:
def connectToDB():
    global conn
    # Establish the connection
    try:
        conn = pyodbc.connect(connection_string)
        print("Connected to SQL Server")
    except pyodbc.Error as ex:
        print("Failed to connect to SQL Server:", ex)


@app.post("/shorten_url")
def shorten_url(url: str):
    cursor = conn.cursor()

    print('INFO:     IN SHORTEN URL')
    print('INFO:     CHECKING WHETHER URL EXISTS IN TABLE OR NOT')
    # Check if the URL already exists in the database
    query = f"SELECT shorten_url FROM URL_table WHERE original_url = '{url}'"
    cursor.execute(query)
    existing_url = cursor.fetchone()

    if existing_url:
        print('INFO:     URL FOUND')
        # URL already exists, retrieve the existing shortened URL
        shorten_url = existing_url[0]
        return shorten_url

    else:
        print('INFO:     INSERTING URL TO TABLE')
        # Generate a random 6-character string as the shortened URL
        shorten_url = generate_shorten_url()
        print(f'INFO:     SHORTEN URL {shorten_url}')

        # Calculate the expiration date (7 days from the current date and time)
        expire_date = calculate_expire_date()
        expire_date_str = expire_date.strftime('%Y-%m-%d %H:%M:%S')
        print(f'INFO:     EXPIRE DATE {expire_date_str}')

        # Call the stored procedure to insert the new URL mapping into the database
        stored_procedure = "InsertURL"
        cursor.execute(f"EXEC {stored_procedure} @original_url = '{url}', "
                       f"@shorten_url = '{shorten_url}', @expire_date = '{expire_date_str}'")
        conn.commit()
        print('INFO:     INSERTED SUCCESSFULLY')

        return shorten_url


# API to get the original URL
# curl -X POST "http://localhost:8000/get_original?shorten_url=9qdmxd"
@app.post("/get_original")
def get_original(shorten_url: str):

    print('INFO:     IN GET ORIGINAL')
    cursor = conn.cursor()

    print('INFO:     INCREASING COUNTER')


    # Call the T-SQL function to get the original URL based on the shortened URL
    function_query = f"SELECT dbo.GetOriginalURL('{shorten_url}')"
    cursor.execute(function_query)
    original_url = cursor.fetchone()
    print(f'INFO:     GETTING ORIGINAL URL')

    if original_url:
        print(f'INFO:     ORIGINAL URL {original_url}')
        original = original_url[0]
        if original is None:
            original = "*** "  # Replace 'null' with an empty string
        # Call the stored procedure to increase the view count
        stored_procedure = "IncreaseViewCount"
        cursor.execute(f"EXEC {stored_procedure} @shorten_url = '{shorten_url}'")
        print(f'INFO:     VIEW INCREASED')

        conn.commit()
        return original
    else:
        raise HTTPException(status_code=404, detail="Shortened URL not found")


# API to get statistics
# curl -X GET http://localhost:8000/dashboard
@app.get("/dashboard")
def dashboard():

    print(f'counter : {counter}')
    print(f'INFO:     IN DASHBOARD')
    cursor = conn.cursor()

    # Call the T-SQL function to get the sum of URLs added today
    function_query = "SELECT dbo.GetUrlsAddedToday()"
    cursor.execute(function_query)
    urls_added_today = cursor.fetchone()[0]
    print(f'INFO:     TODAY URLS {urls_added_today}')

    # Select the top 3 viewed ranked URLs from the view
    query = "SELECT original_url, shorten_url, url_view FROM dbo.Top3ViewedLinks"
    cursor.execute(query)
    top_links = cursor.fetchall()

    # Convert top_links to a list of dictionaries
    top_links_dict = [
        {"URL": link[0]}
        for link in top_links
    ]

    # Retrieve all the mappings details using the view
    view_query = "SELECT * FROM MappingDetails"
    cursor.execute(view_query)
    mappings = cursor.fetchall()

    # Convert mappings to a list of dictionaries
    mappings_dict = [
        {"original_url": mapping[0], "shorten_url": mapping[1], "expire_date": mapping[2], "url_view": mapping[3]}
        for mapping in mappings
    ]

    # Call the SQL function to get the number of rows added today
    query = "SELECT dbo.GetRowsAddedToday()"
    cursor.execute(query)
    rows_added_today = cursor.fetchone()[0]

    return {
        "Number of URLs added today": urls_added_today,
        "Number of views on shorten URLs today": rows_added_today,
        "Top 3 viewed links": top_links_dict,
        "All Links": mappings_dict
    }


# Close the connection when the server stops
@app.on_event("shutdown")
def shutdown_event():
    if conn is not None:
        conn.close()
        print("Disconnected from SQL Server")


if __name__ == "__main__":
    connectToDB()
    uvicorn.run(app, host="0.0.0.0", port=8000)
