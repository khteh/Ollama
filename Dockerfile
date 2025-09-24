FROM ollama/ollama:latest
MAINTAINER Kok How, Teh <funcoolgeeek@gmail.com>
ARG DEBIAN_FRONTEND=noninteractive
ADD run.sh /usr/local/bin/run.sh
EXPOSE 11434
ENTRYPOINT ["/usr/local/bin/run.sh"]
#ENTRYPOINT ["/bin/ollama"]
CMD ["bash"]
#CMD ["/bin/ollama", "serve"]