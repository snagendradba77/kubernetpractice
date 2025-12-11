from flask import Flask, jsonify
import psycopg2
import os

app = Flask(__name__)

# Database connection parameters from environment variables
DB_HOST = os.getenv('DB_HOST', 'postgres.db-ns.svc.cluster.local')
DB_PORT = os.getenv('DB_PORT', 5432)
DB_USER = os.getenv('DB_USER', 'postgres')
DB_PASSWORD = os.getenv('DB_PASSWORD', 'StrongPassword123')
DB_NAME = os.getenv('DB_NAME', 'appdb')

def get_db_connection():
    conn = psycopg2.connect(
        host=DB_HOST,
        port=DB_PORT,
        user=DB_USER,
        password=DB_PASSWORD,
        dbname=DB_NAME
    )
    return conn

@app.route('/')
def index():
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute('SELECT NOW();')
        result = cur.fetchone()
        cur.close()
        conn.close()
        return jsonify({"status": "success", "time": str(result[0])})
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

