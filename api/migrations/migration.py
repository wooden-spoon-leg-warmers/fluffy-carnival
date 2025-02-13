import psycopg2
import os

# Load the database connection URI from environment variable
DATABASE_URL = os.getenv('DATABASE_URL', 'postgres://api:password@postgresql.database.svc.cluster.local:5432/api')

# Establish connection
conn = psycopg2.connect(DATABASE_URL)
cur = conn.cursor()

# Create tables
cur.execute("""
    CREATE TABLE IF NOT EXISTS mytable (
        id SERIAL PRIMARY KEY,
        myapi_id VARCHAR(50),
        myapi_name VARCHAR(100),
        myapi_created_at TIMESTAMP
    );
""")

cur.execute("""
    CREATE TABLE IF NOT EXISTS othertable (
        id SERIAL PRIMARY KEY,
        myapi2_id VARCHAR(50),
        myapi2_name VARCHAR(100),
        myapi2_created_at TIMESTAMP
    );
""")

# Commit changes and close connection
conn.commit()
cur.close()
conn.close()

print("Tables created successfully.")