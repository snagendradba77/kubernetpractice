from flask import Flask
import psycopg2
import os

app = Flask(__name__)

def get_db():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "postgres"),
        user=os.getenv("DB_USER", "postgres"),
        password=os.getenv("DB_PASSWORD", "StrongPassword123"),
        dbname="postgres"
    )

@app.route("/")
def home():
    conn = get_db()
    cur = conn.cursor()
    cur.execute("SELECT version();")
    result = cur.fetchone()
    return f"Postgres Version: {result[0]}"

