# Ollama LLM Model Server

Customized Ollama image with:

1. NVIDIA Container Toolkit packages
2. Load models from `MODELS` environment variable

## Check Ollama ENV variables:

- https://github.com/ollama/ollama/issues/2941

```
$ o help serve
Start ollama

Usage:
  ollama serve [flags]

Aliases:
  serve, start

Flags:
  -h, --help   help for serve

Environment Variables:
      OLLAMA_DEBUG               Show additional debug information (e.g. OLLAMA_DEBUG=1)
      OLLAMA_HOST                IP Address for the ollama server (default 127.0.0.1:11434)
      OLLAMA_KEEP_ALIVE          The duration that models stay loaded in memory (default "5m")
      OLLAMA_MAX_LOADED_MODELS   Maximum number of loaded models per GPU
      OLLAMA_MAX_QUEUE           Maximum number of queued requests
      OLLAMA_MODELS              The path to the models directory
      OLLAMA_NUM_PARALLEL        Maximum number of parallel requests
      OLLAMA_NOPRUNE             Do not prune model blobs on startup
      OLLAMA_ORIGINS             A comma separated list of allowed origins
      OLLAMA_SCHED_SPREAD        Always schedule model across all GPUs

      OLLAMA_FLASH_ATTENTION     Enabled flash attention
      OLLAMA_KV_CACHE_TYPE       Quantization type for the K/V cache (default: f16)
      OLLAMA_LLM_LIBRARY         Set LLM library to bypass autodetection
      OLLAMA_GPU_OVERHEAD        Reserve a portion of VRAM per GPU (bytes)
      OLLAMA_LOAD_TIMEOUT        How long to allow model loads to stall before giving up (default "5m")
```

## Check Ollama status

```
root@ollama-0:/# ollama ps
NAME               ID              SIZE     PROCESSOR         UNTIL
llama3.3:latest    a6eb4748fd29    47 GB    93%/7% CPU/GPU    35 seconds from now
root@ollama-0:/# nvidia-smi
Sat Apr  5 05:01:27 2025
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 560.35.03              Driver Version: 560.35.03      CUDA Version: 12.6     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA RTX A2000 Laptop GPU    Off |   00000000:01:00.0  On |                  N/A |
| N/A   51C    P8              8W /   60W |    2484MiB /   4096MiB |      0%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+

+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI        PID   Type   Process name                              GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
+-----------------------------------------------------------------------------------------+
```

## Check model parameters

```
root@ollama-0:/# ollama show llama3.3
  Model
    architecture        llama
    parameters          70.6B
    context length      131072
    embedding length    8192
    quantization        Q4_K_M

  Parameters
    stop    "<|start_header_id|>"
    stop    "<|end_header_id|>"
    stop    "<|eot_id|>"

  License
    LLAMA 3.3 COMMUNITY LICENSE AGREEMENT
    Llama 3.3 Version Release Date: December 6, 2024
```

## Check GPU availability on k8s nodes

- `kubectl describe node <nodename>`

```
Capacity:
  cpu:                16
  ephemeral-storage:  959786032Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             71442128Ki
  nvidia.com/gpu:     1
  pods:               110
Allocatable:
  cpu:                16
  ephemeral-storage:  958737456Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             71339728Ki
  nvidia.com/gpu:     1
  pods:               110
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
