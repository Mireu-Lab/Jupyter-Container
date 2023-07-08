FROM ubuntu:latest

RUN apt-get -y update &&\
    apt-get -y upgrade &&\
    apt-get -y autoremove &&\
    apt-get install -y sudo\
    vim\
    unzip\
    nano\ 
    htop\ 
    wget\ 
    net-tools\ 
    git\
    python3\
    python3-pip

RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime &&\
    chsh -s /bin/bash root &&\
    pip3 install jupyterlab &&\
    jupyter lab --generate-config

COPY /jupyter_lab_config.py /root/.jupyter/jupyter_lab_config.py

RUN apt-get update &&\
    pip install --upgrade\
    jupyterlab\
    jupyterlab-git

RUN mkdir workspace
WORKDIR /workspace
VOLUME [ "/workspace" ]

ENV PASSWORD 'jupyter1234'

CMD jupyter lab --ip=0.0.0.0 --NotebookApp.token=${PASSWORD} --allow-root