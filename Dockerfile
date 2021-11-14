FROM ubuntu:20.04
LABEL maintainer="Letícia Maria Pequeno Madureira <lmadurei@andrew.cmu.edu>"

# arguments

ARG URL=https://arquivos.ufsc.br/f/7d651f269bf445608ce1/?dl=1
ARG NAME=orca_5_0_1_linux_x86-64_shared_openmpi411
ARG PREFIX=/opt
ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=America/Sao_Paulo


USER root
WORKDIR $PREFIX

RUN apt update && \
    apt upgrade --yes && \
    apt install --yes openmpi-bin && \
    apt install --yes vim && \
    apt install --yes wget && \
    wget $URL -O orca.tar.zst && \
    apt install --yes zstd && \
    tar -I zstd -xvf orca.tar.zst && \
    mv $NAME orca && \
    rm orca.tar.zst && \
    rm -rf /var/lib/apt/lists/* && \
    useradd --create-home --shell /bin/bash $USER && \
    echo export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$PREFIX/orca" >> /home/$USER/.bashrc && \
    echo export OMPI_MCA_btl_vader_single_copy_mechanism=none >> /home/$USER/.bashrc

USER $USER
WORKDIR /home/$USER
