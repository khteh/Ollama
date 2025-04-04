#!/bin/bash
ollama serve
sleep 10
MODEL="${MODELS//,/ }"
for i in "${MODEL[@]}"; do \
      echo model: $i  \
      ollama pull $i \
    done
