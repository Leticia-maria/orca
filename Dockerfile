FROM ubuntu:20.04
LABEL maintainer="Letícia Maria Pequeno Madureira <lmadurei@andrew.cmu.edu>

# arguments

ARG URL=
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
    wget $URL
