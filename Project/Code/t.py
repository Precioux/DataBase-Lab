import pyodbc

# Set up the connection details
server = 'NYX'
database = 'test'
username = 'project'
password = '9839039'
connection_string = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}'

# Global variable to store the connection
conn = None

def connectToDB():
    global conn
    # Establish the connection
    try:
        conn = pyodbc.connect(connection_string)
        print("Connected to SQL Server")
    except pyodbc.Error as ex:
        print("Failed to connect to SQL Server:", ex)

def insertDataIntoTable(name, num):
    try:
        cursor = conn.cursor()
        query = f"INSERT INTO test_table (name, num) VALUES (?, ?)"
        cursor.execute(query, (name, num))
        conn.commit()
        print("Data inserted successfully")
    except pyodbc.Error as ex:
        print("Failed to insert data into table:", ex)

if __name__ == "__main__":
    connectToDB()

    # Example usage
    name = "donna"
    num = 12
    insertDataIntoTable(name, num)
