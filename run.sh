#!/bin/bash
# https://github.com/ollama/ollama/issues/10136
# Note: NO SPACE in-between ">("
ollama serve 2>&1 | tee >(grep -v "/api/version" > /var/log/ollama/log) &
pid=$!                       # ADD: save the process ID of the server
sleep 10
models=(${MODELS//,/ })
for i in "${models[@]}"; do
      echo model: $i
      ollama pull $i
done
wait "$pid"                  # ADD: keep the script running as long as the server is too