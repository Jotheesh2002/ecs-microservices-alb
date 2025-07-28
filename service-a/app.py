from flask import Flask, jsonify
import os
import socket

app = Flask(__name__)

@app.route("/")
def home():
    hostname = socket.gethostname()
    return jsonify({
        "service": "Service A",
        "message": "Hello from Service A!",
        "hostname": hostname,
        "version": "1.0.0",
        "developer": "Jotheesh"
    })

@app.route("/health")
def health():
    return jsonify({"status": "healthy", "service": "service-a"})

@app.route("/api/v1/a")
def api_a():
    hostname = socket.gethostname()
    return jsonify({
        "service": "Service A",
        "endpoint": "/api/v1/a",
        "message": "API endpoint for Service A",
        "hostname": hostname,
        "features": ["Auto-scaling", "Health checks", "Load balancing"]
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80, debug=True)
