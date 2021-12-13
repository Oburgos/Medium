#!/bin/bash
apt update -y
apt install nodejs npm -y
npm install pm2 -g
git clone https://github.com/abkunal/Chat-App-using-Socket.io
cd Chat-App-using-Socket.io
npm i
pm2 start app.js