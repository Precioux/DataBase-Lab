import pyodbc
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import uvicorn
from schema import URL
import secrets
import string
from datetime import date, timedelta
import time
from fastapi import FastAPI

# fastapi server instance
app = FastAPI()

# Set up the connection details
server = 'NYX'
database = 'Project'
username = 'project'
password = '9839039'
connection_string = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}'
# Global variable to store the connection
conn = None
counter = 0


def delete_expired_urls():
    cursor = conn.cursor()

    try:
        # Start an explicit transaction
        cursor.execute("BEGIN TRANSACTION")

        # Check for expired URLs
        query = "SELECT shorten_url, submit_date, expire_date FROM URL"
        cursor.execute(query)
        urls = cursor.fetchall()

        if urls:
            current_date = time.strftime('%Y-%m-%d %H:%M:%S')
            for url in urls:
                shorten_url, submit_date, expire_date = url

                # Calculate the difference in days between the expiration date and current date
                date_diff_query = f"SELECT DATEDIFF(day, '{current_date}', '{expire_date}')"
                cursor.execute(date_diff_query)
                days_diff = cursor.fetchone()[0]

                if days_diff > 7:
                    # Delete the expired URL
                    delete_query = f"DELETE FROM URL WHERE shorten_url = '{shorten_url}'"
                    cursor.execute(delete_query)
                    print("Expired URL deleted:", shorten_url)

        # Commit the transaction
        cursor.execute("COMMIT")

    except:
        # Rollback the transaction in case of an exception
        cursor.execute("ROLLBACK")

    finally:
        # Reset the isolation level to the default value (READ COMMITTED)
        cursor.execute("SET TRANSACTION ISOLATION LEVEL READ COMMITTED")


def calculate_expire_date():
    today = date.today()
    expire_date = today + timedelta(days=7)
    return expire_date


# to generate shorten url
def generate_shorten_url():
    alphabet = string.ascii_lowercase + string.digits
    shorten_url = ''.join(secrets.choice(alphabet) for _ in range(6))
    return shorten_url


def connectToDB():
    global conn
    # Establish the connection
    try:
        conn = pyodbc.connect(connection_string)
        print("Connected to SQL Server")
    except pyodbc.Error as ex:
        print("Failed to connect to SQL Server:", ex)


# API to get all data from the URL table
# curl -X GET http://localhost:8000/up
@app.get("/up")
def up():
    print('Hi!')
    return 'Hi!'


# API to shorten URL
# curl -X POST "http://localhost:8000/shorten_url?url=https://aut.ac.ir/"
@app.post("/shorten_url")
def shorten_url(url: str):
    print('INFO:     IN SHORTEN URL')
    cursor = conn.cursor()

    print('INFO:     CHECKING WHETHER URL EXISTS IN TABLE OR NOT')
    # Check if the URL already exists in the database
    query = f"SELECT shorten_url, views FROM URL WHERE original_url = '{url}'"
    cursor.execute(query)
    existing_url = cursor.fetchone()

    if existing_url:
        print('INFO:     URL FOUND')
        # URL already exists, retrieve the existing shortened URL and view count
        shorten_url = existing_url[0]
        views = existing_url[1]
        print(shorten_url)
        print(views)
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
        print('INFO:     INSERTED SUCCESSFULLY')
        return shorten_url


# API to get the original URL
# curl -X POST "http://localhost:8000/get_original?shorten_url=m6mu3t"
@app.post("/get_original")
def get_original(shorten_url: str):
    cursor = conn.cursor()
    global counter
    counter = counter + 1

    # Call the T-SQL function to get the original URL based on the shortened URL
    function_query = f"SELECT dbo.GetOriginalURL('{shorten_url}')"
    cursor.execute(function_query)
    original_url = cursor.fetchone()

    if original_url:
        original = original_url[0]
        if original is None:
            original = "*** "  # Replace 'null' with an empty string
        # Call the stored procedure to increase the view count
        stored_procedure = "IncreaseViewCount"
        cursor.execute(f"EXEC {stored_procedure} @shorten_url = '{shorten_url}'")

        conn.commit()
        return original
    else:
        raise HTTPException(status_code=404, detail="Shortened URL not found")


# API to get statistics
@app.get("/dashboard")
def dashboard():
    cursor = conn.cursor()

    # Call the T-SQL function to get the sum of URLs added today
    function_query = "SELECT dbo.GetUrlsAddedToday()"
    cursor.execute(function_query)
    urls_added_today = cursor.fetchone()[0]

    # Call the T-SQL function to get the top 3 viewed ranked URLs
    function_query = "SELECT * FROM dbo.GetTop3ViewedLinks()"
    cursor.execute(function_query)
    top_links = cursor.fetchall()

    # Retrieve all the mappings details using the view
    view_query = "SELECT * FROM MappingDetails"
    cursor.execute(view_query)
    mappings = cursor.fetchall()

    return {
        "Number of URLs added today": urls_added_today,
        "Number of views on shorten urls today": counter,
        "Top 3 viewed links": top_links,
        "All mappings details": mappings
    }


# API to drop the URL table
@app.get("/drop")
def drop_table():
    cursor = conn.cursor()

    # Execute the DROP TABLE statement
    cursor.execute("DROP TABLE URL")
    conn.commit()

    return "URL table dropped successfully"


# Close the connection when the server stops
@app.on_event("shutdown")
def shutdown_event():
    if conn is not None:
        conn.close()
        print("Disconnected from SQL Server")


if __name__ == "__main__":
    connectToDB()
    delete_expired_urls()
    uvicorn.run(app, host="0.0.0.0", port=8000)
