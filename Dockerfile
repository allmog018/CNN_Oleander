FROM nvidia/cuda:10.1-cudann7-runtime-ubuntu18.04
RUN apt-get update && apt-get insta;; -y python3-pip sudo
RUN useradd -m allmog018
RUN chown -R allmog018:allmog018 /home/allmog018
COPY --chown allmog . /home/allmog018
USER allmog018
RUN cd /home/allmog/ && pip3 install -r requirements.txt
WORKDIR /home/allmog018