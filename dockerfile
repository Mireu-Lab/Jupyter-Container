FROM 12.1.1-cudnn8-runtime-ubuntu22.04

RUN apt-get -y update && apt-get -y upgrade && apt-get -y autoremove

RUN apt-get install -y sudo\
                    vim\
                    unzip\
                    nano\ 
                    htop\ 
                    wget\ 
                    net-tools\ 
                    git

RUN apt-get install -y python3\
                    python3-pip

RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime
RUN chsh -s /bin/bash root

RUN pip3 install jupyterlab

RUN jupyter lab --generate-config
COPY /jupyter_lab_config.py /root/.jupyter/jupyter_lab_config.py

RUN apt-get update
RUN pip install --upgrade\
                jupyterlab\
                jupyterlab-git

RUN mkdir workspace
WORKDIR /workspace
VOLUME [ "/workspace" ]

ENV PASSWORD='jupyter1234'

CMD jupyter lab --ip=0.0.0.0 --NotebookApp.token=${PASSWORD} --allow-root