FROM nvidia/cuda:12.1.1-cudnn8-runtime-centos7

RUN yum -y update &&\ 
    yum -y upgrade &&\ 
    yum -y autoremove &&\
    yum install -y sudo\
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
    sudo -H pip3 install --upgrade --ignore-installed pip setuptools &&\
    pip3 install jupyterlab &&\
    jupyter lab --generate-config

COPY /jupyter_lab_config.py /root/.jupyter/jupyter_lab_config.py

RUN yum update &&\
    pip install --upgrade\
    jupyterlab\
    jupyterlab-git

RUN mkdir workspace
WORKDIR /workspace
VOLUME [ "/workspace" ]

ENV PASSWORD='jupyter1234'

CMD jupyter lab --ip=0.0.0.0 --NotebookApp.token=${PASSWORD} --allow-root