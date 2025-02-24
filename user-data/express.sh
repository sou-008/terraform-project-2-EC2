#!/bin/bash
sudo apt-get update -y
sudo apt-get install nodejs npm -y

# Install Express
mkdir /home/ubuntu/express-app
cd /home/ubuntu/express-app
npm init -y
npm install express

# Create and run a simple Express app
echo "const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello, Express!');
});

app.listen(80, () => {
  console.log('Express app listening on port 80');
});" > /home/ubuntu/express-app/app.js

# Start Express app
sudo node /home/ubuntu/express-app/app.js &