FROM fedora:latest

RUN yum -y update && yum -y upgrade && yum -y autoremove
RUN yum install -y sudo\
                    vim\
                    unzip\
                    nano\ 
                    htop\ 
                    wget\ 
                    net-tools\ 
                    git

RUN yum install -y python3\
                python3-pip

RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime
RUN chsh -s /bin/bash root

RUN pip3 install jupyterlab

RUN jupyter lab --generate-config
COPY /jupyter_lab_config.py /root/.jupyter/jupyter_lab_config.py

RUN yum update
RUN pip install --upgrade\
                jupyterlab\
                jupyterlab-git

RUN mkdir workspace
WORKDIR /workspace
VOLUME [ "/workspace" ]

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--NotebookApp.token=''", "--NotebookApp.password=''", "--allow-root"]