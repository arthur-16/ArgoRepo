from flask import Flask, jsonify, Response

app = Flask(__name__)

@app.get("/")
def home():
    return jsonify(message="hello from python demo")

@app.get("/healthz")
def healthz():
    # Simple readiness/liveness endpoint
    return Response(status=200)

if __name__ == "__main__":
    # Listen on 0.0.0.0:8080 so Kubernetes Service can reach it
    app.run(host="0.0.0.0", port=8080)
