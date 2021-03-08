#!/bin/bash
sudo docker build -t websiteoverview .
port=80
sudo docker run --name=web --restart=always -d -p $port:80 websiteoverview
