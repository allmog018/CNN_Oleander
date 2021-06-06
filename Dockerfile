FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04
RUN apt-get update && apt-get install -y python3-pip sudo 
RUN apt-get install -y software-properties-common sudo



RUN add-apt-repository ppa:deadsnakes/ppa
#$ sudo apt-get update
#$ sudo apt-get install python3.8

RUN useradd -m allmog018
RUN chown -R allmog018:allmog018 /home/allmog018/
COPY --chown=allmog018 . /home/allmog018
USER allmog018
RUN cd /home/allmog018/ && pip3 install -r requirements.txt
WORKDIR /home/allmog018