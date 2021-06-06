FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04
RUN apt-get update && apt-get install -y python3-pip sudo 
RUN apt install -y python3.7 sudo
RUN apt-get install -y python3.7-dev sudo
RUN useradd -m allmog018
RUN chown -R allmog018:allmog018 /home/allmog018/
COPY --chown=allmog018 . /home/allmog018
USER allmog018
RUN cd /home/allmog018/ && pip3 install -r requirements.txt
WORKDIR /home/allmog018