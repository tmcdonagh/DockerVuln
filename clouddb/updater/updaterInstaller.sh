#!/bin/bash
sudo docker build -t updater .
sudo docker run \
  --name=updater \
  --restart=always \
  -d updater \
