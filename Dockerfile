FROM ollama/ollama:latest
MAINTAINER Kok How, Teh <funcoolgeeek@gmail.com>
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update -y --fix-missing
RUN apt upgrade -y
RUN apt install -y software-properties-common apt-transport-https curl sudo gnupg pipenv unzip dnsutils wget python3 python3-pip
RUN curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey \
    | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
RUN curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list \
    | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' \
    | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
RUN sudo apt-get update
RUN apt install -y nvidia-container-toolkit
ADD run.sh /usr/local/bin/run.sh
EXPOSE 11434
ENTRYPOINT ["/usr/local/bin/run.sh"]
CMD ["bash"]