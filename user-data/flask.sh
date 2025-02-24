#!/bin/bash
sudo apt-get update -y
sudo apt-get install python3-pip -y
pip3 install flask

# Create and run a simple Flask app
echo "from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, Flask!' 

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)" > /home/ubuntu/app.py

# Start Flask app
sudo python3 /home/ubuntu/app.py &