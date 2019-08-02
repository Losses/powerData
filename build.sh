#! /bin/bash
docker build -t powerdata:v1 . --build-arg http_proxy=http://127.0.0.1:7890 --build-arg https_proxy=http://127.0.0.1:7890 --network=host
