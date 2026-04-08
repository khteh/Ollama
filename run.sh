#!/bin/bash
ollama serve 2>&1 | tee /var/log/ollama/log &
pid=$!                       # ADD: save the process ID of the server
sleep 10
models=(${MODELS//,/ })
for i in "${models[@]}"; do
      echo model: $i
      ollama pull $i
done
wait "$pid"                  # ADD: keep the script running as long as the server is too