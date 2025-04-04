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

## To modify a modelfile:

- https://github.com/ollama/ollama/issues/10124

```
$ ollama show --modelfile llama3.3:latest > llama3.3-big
```

- Modify `FROM` according to the comment in the file, and add one line `PARAMETER num_gpu 99` to the end of the file. Modify this number according to your VRAM.
- Run the modified model:

```
$ ollama create -f llama3.3-big llama3.3-big
```
