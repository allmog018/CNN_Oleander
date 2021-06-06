FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04
RUN apt-get update && apt-get install -y python-pip sudo 

RUN apt-get install -y python3-pip sudo 

RUN apt-get install -y software-properties-common sudo
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN apt-get install -y python3.8 sudo

#RUN python -m pip install --upgrade pip

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
RUN apt install -y python3.8-distutils sudo


RUN useradd -m allmog018
RUN chown -R allmog018:allmog018 /home/allmog018/
COPY --chown=allmog018 . /home/allmog018
USER allmog018
RUN cd /home/allmog018/ && pip3 install -r requirements.txt
WORKDIR /home/allmog018