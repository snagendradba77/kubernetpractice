import os
import psycopg2

conn = psycopg2.connect(
    host="postgres.db.svc.cluster.local",
    port=5431,
    database="appdb",
    user=os.getenv("POSTGRES_USER"),
    password=os.getenv("POSTGRES_PASSWORD")
)
print("App connected to PostgreSQL")

