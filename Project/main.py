import pyodbc

# Set up the connection details
server = 'NYX'
database = 'Project'
username = 'project'
password = '9839039'
connection_string = f'DRIVER={{SQL Server}};SERVER={server};DATABASE={database};UID={username};PWD={password}'

# Establish the connection
try:
    conn = pyodbc.connect(connection_string)
    print("Connected to SQL Server")
except pyodbc.Error as ex:
    print("Failed to connect to SQL Server:", ex)

# Close the connection
conn.close()
