FROM nvidia/cuda:11.3.0-cudnn8-runtime-ubuntu20.04

# #######################################################################################
# Install Ubuntu Packages
ARG DEBIAN_FRONTEND=noninteractive
RUN rm -f /etc/apt/sources.list.d/*.list

RUN apt-get update && \
    apt-get install -y build-essential\
        curl wget ca-certificates tmux git net-tools \
        sudo g++ make neovim git

RUN apt-get install nodejs npm -y
RUN apt-get install python3 python3-pip -y

# #######################################################################################
# Upgrade nodejs
RUN echo "-k" > ~/.curlrc && hash -r && npm set strict-ssl false && npm install -g n
RUN n stable

# #######################################################################################
# VIM
RUN mkdir -p  ~/.config/nvim
COPY ./init.vim /root/.config/nvim/init.vim
RUN echo '{\n"https.rejectUnauthorized": false,\n"http.proxyStrictSSL": false\n}' > /root/.config/nvim/coc-settings.json
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

RUN nvim +PlugInstall +qa
RUN nvim +"CocInstall -sync coc-pyright" +qa

# # #######################################################################################
# # Python Packages
RUN pip3 install torch==1.12.0 transformers onnx
RUN pip3 install pandas minio docker
RUN pip3 install fastapi gunicorn requests
RUN pip3 install fluent-logger pylint python-dotenv

RUN apt-get clean && \
    rm -rf /config/* /tmp/* /var/lib/apt/lists/* /var/tmp/*

WORKDIR /app