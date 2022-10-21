FROM nvidia/cuda:11.3.0-cudnn8-runtime-ubuntu20.04

# #######################################################################################
# Install ubuntu packages
ARG DEBIAN_FRONTEND=noninteractive
RUN rm -f /etc/apt/sources.list.d/*.list

RUN apt-get update

RUN apt-get install -y build-essential nodejs npm 
RUN apt-get install -y python3 python3-pip
RUN apt-get install -y curl wget ca-certificates tmux git net-tools sudo g++ make git software-properties-common



# #######################################################################################
# Upgrade nodejs
RUN echo "-k" > ~/.curlrc && hash -r && npm set strict-ssl false && npm install -g n
RUN n stable

# #######################################################################################
# Install python packages
RUN pip3 install torch==1.12.0 transformers onnx
RUN pip3 install pandas minio docker
RUN pip3 install fastapi gunicorn uvicorn requests
RUN pip3 install fluent-logger pylint python-dotenv

# #######################################################################################
# Set VIM environment
RUN add-apt-repository ppa:jonathonf/vim -y && apt-get update -y && apt-get install vim -y
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

COPY .vimrc /root/.vimrc
RUN vi +PlugInstall +qa
RUN vi +"CocInstall -sync coc-pyright" +qa

# #######################################################################################
# MinIO Client
RUN wget https://dl.min.io/client/mc/release/linux-amd64/mc -P /bin
RUN chmod +x /bin/mc
RUN export PATH=/bin/mc:$PATH

# #######################################################################################
# Clean apt
RUN apt-get clean && \
    rm -rf /config/* /tmp/* /var/lib/apt/lists/* /var/tmp/*

# #######################################################################################
# Set workspace directory
WORKDIR /workspace

# #######################################################################################
# Setup FastAPI Project
RUN mkdir -p /workspace/app
RUN cd /workspace/app && \
    mkdir routes models services && \
    touch routes/__init__.py models/__init__.py services/__init__.py \
        __init__.py app.py dependencies.py