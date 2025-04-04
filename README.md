# Ollama LLM Model Server

Customized Ollama image with:

1. NVIDIA Container Toolkit packages
2. Load models from `MODELS` environment variable

## Check Ollama status

```
$ ollama ps
NAME               ID              SIZE     PROCESSOR         UNTIL
llama3.3:latest    a6eb4748fd29    47 GB    93%/7% CPU/GPU    4 minutes from now
```

## Check Nvidia usage:

```
$ nvtop
```
