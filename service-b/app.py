from flask import Flask, jsonify
import os
import socket

app = Flask(__name__)

@app.route("/")
def home():
    hostname = socket.gethostname()
    return jsonify({
        "service": "Service B",
        "message": "Hello from Service B!",
        "hostname": hostname,
        "version": "1.0.0",
        "developer": "Jotheesh"
    })

@app.route("/health")
def health():
    return jsonify({"status": "healthy", "service": "service-b"})

@app.route("/api/v1/b")
def api_b():
    hostname = socket.gethostname()
    return jsonify({
        "service": "Service B",
        "endpoint": "/api/v1/b",
        "message": "API endpoint for Service B",
        "hostname": hostname,
        "features": ["Container orchestration", "CI/CD", "Infrastructure as Code"]
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80, debug=True)
