from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Support service is running"

@app.route("/support")
def support():
    return "Project 4 Support Service Response"

@app.route("/health")
def health():
    return "OK", 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
