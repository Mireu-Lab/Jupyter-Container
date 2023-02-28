FROM ubnutn:latest

ENV MYPASSWORD=Hosting

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

RUN useradd -rm -d /home/Jupyter\
                -s /bin/bash\
                -g root -G sudo\
                -u 1001 Jupyter
RUN passwd -d Jupyter

USER Jupyter
WORKDIR /home/Jupyter

COPY /password.py /password.py

RUN pip3 install jupyterlab\
                python-dotenv

RUN jupyter lab --generate-config

RUN apt-get update
RUN pip3 install "jupyterlab-kite>=2.0.2"
RUN pip install --upgrade\
                jupyterlab\
                jupyterlab-git

CMD ["/setup.sh"]