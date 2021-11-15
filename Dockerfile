FROM codercom/enterprise-base:ubuntu
LABEL maintainer="Letícia Maria Pequeno Madureira <lmadurei@andrew.cmu.edu>"

# arguments
ARG URL=https://arquivos.ufsc.br/f/7d651f269bf445608ce1/?dl=1
ARG NAME=orca_5_0_1_linux_x86-64_shared_openmpi411
ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=America/Sao_Paulo
ARG PREFIX=/opt
ARG USER=leticia
USER root
WORKDIR $PREFIX
RUN apt update && \
    apt upgrade --yes && \
    apt install build-essential && \
    apt install --yes vim && \
    apt install --yes wget && \
    apt install --yes make && \
    apt install --yes gfortran && \
# openmpi-4.1.1 installation
    cd /tmp && \
    wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.1.tar.gz && \
    tar xvf openmpi-4.1.1.tar.gz && \
    cd openmpi-4.1.1 && \
    ./configure --prefix=/opt/orca-5.0.0/openmpi-4.1.1 && \
    make all && \
    make install && \
# orca-5.0.1 installation
    wget $URL -O orca-5.0.1.tar.zst && \
    apt install --yes zstd && \
    tar -I zstd -xvf orca-5.0.1.tar.zst && \
    mv $NAME orca-5.0.1 && \
    rm orca-5.0.1.tar.zst && \
    rm -rf /var/lib/apt/lists/* && \
    useradd --create-home --shell /bin/bash $USER && \
    echo export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$PREFIX/orca-5.0.1" >> /home/$USER/.bashrc && \
    echo export openmpi_path=/opt/orca-5.0.1/openmpi-4.1.1 >> /home/$USER/.bashrc && \
    source /home/$USER/.bashrc
USER $USER
WORKDIR /home/$USER
CMD ["tail", "-f", "/dev/null"]

