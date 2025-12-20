import os
import psycopg2
from flask import Flask, request, jsonify

app = Flask(__name__)

def get_connection():
    return psycopg2.connect(
        host="postgres.db.svc.cluster.local",
        port=5431,
        database="appdb",
        user=os.getenv("POSTGRES_USER"),
        password=os.getenv("POSTGRES_PASSWORD")
    )

@app.route("/")
def hello():
    # Simple health endpoint for probes
    return "Python app is running and connected to Postgres!"

@app.route("/insert_user", methods=["POST"])
def insert_user():
    data = request.json or {}
    username = data.get("username")
    email = data.get("email")

    if not username or not email:
        return jsonify({"error": "username and email are required"}), 400

    try:
        conn = get_connection()
        cur = conn.cursor()
        cur.execute("INSERT INTO users (username, email) VALUES (%s, %s)", (username, email))
        conn.commit()
        cur.close()
        conn.close()
        return jsonify({"status": "success", "username": username, "email": email}), 201
    except psycopg2.IntegrityError:
        return jsonify({"error": "email must be unique"}), 409
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route("/users", methods=["GET"])
def list_users():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("SELECT id, username, email, created_at FROM users ORDER BY id DESC")
    rows = cur.fetchall()
    cur.close()
    conn.close()

    return jsonify([
        {"id": r[0], "username": r[1], "email": r[2], "created_at": r[3].isoformat()}
        for r in rows
    ])

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

