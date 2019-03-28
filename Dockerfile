FROM nvidia/cuda:9.1-cudnn7-devel-ubuntu16.04

# Ref. https://github.com/compsciencelab/ligdream

RUN apt update
RUN apt upgrade -y
RUN apt install wget curl vim git unzip -y
RUN apt install libxrender1 -y

RUN wget -q -c -O /tmp/Miniconda3-latest-Linux-x86_64.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b
ENV PATH /root/miniconda3/bin:$PATH
ENV CONDA_EXE /root/miniconda3/bin/conda
RUN conda create -y -n py35 python=3.5
ENV PATH /root/miniconda3/envs/py35/bin:$PATH
ENV CONDA_DEFAULT_ENV py35
ENV CONDA_PREFIX /root/miniconda3/envs/py35
ENV PYTHONPATH /root:$PYTHONPATH

RUN conda update -y -n base -c defaults conda
RUN conda update -y --all
RUN conda install -y -c rdkit rdkit=2017.09.2.0
RUN conda install -y -c pytorch pytorch=0.3.1 cuda91
RUN conda install -y -c conda-forge keras=2.2.2
RUN conda install -y -c acellera -c psi4 psi4=1.2.1 pcmsolver=1.2.1 htmd=1.13.9

RUN jupyter-notebook --generate-config
RUN echo "c.NotebookApp.ip = '0.0.0.0'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo 'c.NotebookApp.allow_root = True' >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.password = 'sha1:29a4e89b9f3d:2bc031d09642273adf9128ce40320cbc115edc02'" >> /root/.jupyter/jupyter_notebook_config.py

WORKDIR /root
RUN git clone https://github.com/compsciencelab/ligdream.git
WORKDIR /root/ligdream
RUN bash getDataset.sh
RUN bash getWeights.sh
WORKDIR /root

