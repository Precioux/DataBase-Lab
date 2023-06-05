import pyodbc
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import uvicorn
from schema import URL
import secrets
import string
from datetime import date, timedelta

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
#curl -X GET http://localhost:8000/up
@app.get("/up")
def up():
    print('Hi!')
    return 'Hi!'

# API to shorten URL
#curl -X POST "http://localhost:8000/shorten_url?url=https://aut.ac.ir/"
@app.post("/shorten_url")
def shorten_url(url: str):
    print('INFO:     IN SHORTEN URL ')
    cursor = conn.cursor()

    # Check if the URL already exists in the database
    query = f"SELECT shorten_url FROM URL WHERE original_url = '{url}'"
    cursor.execute(query)
    existing_shorten_url = cursor.fetchone()

    if existing_shorten_url:
        # URL already exists, return the existing shortened URL and increase the view count
        existing_shorten_url = existing_shorten_url[0]

        # Call the stored procedure to increase the view count
        stored_procedure = "IncreaseViewCount"
        cursor.execute(f"EXEC {stored_procedure} @shorten_url = '{existing_shorten_url}'")
        conn.commit()

        return existing_shorten_url

    else:
        # Generate a random 6-character string as the shortened URL
        shorten_url = generate_shorten_url()

        # Calculate the expiration date (7 days from the current date and time)
        expire_date = calculate_expire_date()
        expire_date_str = expire_date.strftime('%Y-%m-%d %H:%M:%S')

        # Call the stored procedure to insert the new URL mapping into the database
        stored_procedure = "InsertURL"
        cursor.execute(f"EXEC {stored_procedure} @original_url = '{url}', "
                       f"@shorten_url = '{shorten_url}', @expire_date = '{expire_date_str}'")

        conn.commit()
        return shorten_url

# API to get the original URL
#curl -X POST "http://localhost:8000/get_original?shorten_url=m6mu3t"
@app.post("/get_original")
def get_original(shorten_url: str):
    cursor = conn.cursor()

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





# # API to get statistics
# @app.get("/get_stats")
# def get_stats():
#     # Implement your logic to retrieve and return statistics
#     # This can include the total number of URLs, total views, etc.
#     return {"message": "Statistics data"}
#
#
# # API to get the top links based on views
# @app.get("/get_top")
# def get_top():
#     cursor = conn.cursor()
#
#     # Retrieve the top 3 links based on views
#     query = "SELECT original_url, shorten_url, views " \
#             "FROM URL ORDER BY views DESC LIMIT 3"
#     cursor.execute(query)
#     top_links = cursor.fetchall()
#
#     return top_links
#
#
# # API to get all data from the URL table
# @app.get("/get_data")
# def get_data():
#     cursor = conn.cursor()
#
#     # Retrieve all data from the URL table
#     query = "SELECT * FROM URL"
#     cursor.execute(query)
#     data = cursor.fetchall()
#
#     return data


# Close the connection when the server stops
@app.on_event("shutdown")
def shutdown_event():
    if conn is not None:
        conn.close()
        print("Disconnected from SQL Server")


if __name__ == "__main__":
    connectToDB()
    uvicorn.run(app, host="0.0.0.0", port=8000)

