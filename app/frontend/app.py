from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return """
    <h1>Microservices Platform</h1>
    <p>Project 4 Enterprise ECS Platform</p>
    <ul>
      <li><a href="/sales">Sales Service</a></li>
      <li><a href="/support">Support Service</a></li>
    </ul>
    """

@app.route("/health")
def health():
    return "OK", 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
