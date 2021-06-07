FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04
RUN apt-get update && apt install -y python3-pip sudo 


RUN apt-get install -y software-properties-common sudo
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN apt-get install -y python3.7 sudo

RUN apt-get install -y python3.7-dev sudo

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1
RUN apt install -y python3.7-distutils sudo
#RUN python -m pip install --upgrade pip
RUN apt install curl
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3 get-pip.py --force-reinstall

RUN echo "export PATH=/home/allmog018/.local/bin" >> ~/.bashrc 
RUN pip install --upgrade setuptools 
#RUN apt install python3-virtualenv
#RUN python3 -m virtualenv --python=/usr/bin/python3 /opt/venv
#ENV PATH="/opt/venv/bin:$PATH"
RUN pip install Cython

RUN useradd -m allmog018
RUN chown -R allmog018:allmog018 /home/allmog018/
COPY --chown=allmog018 . /home/allmog018
USER allmog018
RUN cd /home/allmog018/ && pip3 install -r requirements.txt
RUN pip install /home/allmog018/torchvision-0.3.0-cp37-cp37m-manylinux1_x86_64.whl
RUN pip install /home/allmog018/torch-1.1.0-cp37-cp37m-linux_x86_64.whl
WORKDIR /home/allmog018/