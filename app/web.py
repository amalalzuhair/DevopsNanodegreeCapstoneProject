from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return 'Udacity nanodegree app!'d

app.debug = True
app.run(host='0.0.0.0', port=80)