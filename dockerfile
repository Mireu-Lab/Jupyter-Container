FROM nvidia/cuda:12.1.1-cudnn8-runtime-rockylinux9

RUN dnf -y update &&\
    dnf -y upgrade &&\
    dnf -y autoremove &&\
    dnf install -y sudo\
    vim\
    unzip\
    nano\ 
    wget\ 
    net-tools\ 
    git\
    python3\
    python3-pip

RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime &&\
    pip3 install jupyterlab &&\
    jupyter lab --generate-config

COPY /jupyter_lab_config.py /root/.jupyter/jupyter_lab_config.py

RUN dnf update &&\
    pip install --upgrade\
    jupyterlab\
    jupyterlab-git

RUN mkdir workspace
WORKDIR /workspace
VOLUME [ "/workspace" ]

ENV PASSWORD='jupyter1234'

CMD jupyter lab --ip=0.0.0.0 --NotebookApp.token=${PASSWORD} --allow-root