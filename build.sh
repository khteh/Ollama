#!/bin/bash
#$(aws ecr get-login --no-include-email)
docker build -t ollama .
docker tag ollama:latest khteh/ollama:latest
docker push khteh/ollama:latest
