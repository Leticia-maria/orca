FROM ubuntu:20.04
LABEL maintainer="Letícia Maria Pequeno Madureira <lmadurei@andrew.cmu.edu>"

# arguments
ARG URL=https://drive.google.com/file/d/1h8iz_dlh5pmLAw6SFr_g-oboFX8OncaT/view?usp=sharing
ARG FILEID=1h8iz_dlh5pmLAw6SFr_g-oboFX8OncaT
ARG NAME=orca_5_0_2_linux_x86-64_shared_openmpi411.tar.xz
ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=America/New_York
ARG PREFIX=/opt
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
ARG USER=student

USER root
WORKDIR $PREFIX

RUN apt update && \
    apt upgrade --yes && \
    apt install --yes build-essential && \
    apt install --yes vim && \
    apt install --yes python3.9 && \
    apt install --yes python3-pip && \
    apt install --yes git && \
    apt install --yes wget && \
# miniconda installation
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    mkdir /root/.conda && \
    bash Miniconda3-latest-Linux-x86_64.sh -b && \
    rm -f Miniconda3-latest-Linux-x86_64.sh
# openmpi installation
WORKDIR /tmp
RUN wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.1.tar.gz && \
    tar xvf openmpi-4.1.1.tar.gz && \
    rm openmpi-4.1.1.tar.gz
WORKDIR /tmp/openmpi-4.1.1
RUN ./configure --prefix=/opt/orca-5.0.2/openmpi-4.1.1 && \
    make all && \
    make install
# orca-5.0.2 installation
WORKDIR $PREFIX
RUN wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1h8iz_dlh5pmLAw6SFr_g-oboFX8OncaT' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1h8iz_dlh5pmLAw6SFr_g-oboFX8OncaT" -O orca-5.0.2.tar.xz && \
    rm -rf /tmp/cookies.txt && \
    tar -xvf orca-5.0.2.tar.xz && \
    rm  orca-5.0.2.tar.xz && \
    git clone https://github.com/Leticia-maria/orca.git && \
    mv /orca/orca:5/orcainit5 /opt && \
    rm -r orca && \
    rm -rf /var/lib/apt/lists/* && \
    useradd --create-home --shell /bin/bash $USER && \
    echo 'export PATH=$PREFIX/orca:$PATH; export LD_LIBRARY_PATH=$PREFIX/orca:$LD_LIBRARY_PATH' >> /home/$USER/.bashrc && \
    echo 'export PATH=$PREFIX/orca/openmpi-4.1.1/bin:$PATH; export LD_LIBRARY_PATH=$PREFIX/orca/openmpi-4.1.1/lib:$LD_LIBRARY_PATH' >> /home/$USER/.bashrc && \
    /bin/bash -c "source /home/$USER/.bashrc" && \
    /bin/bash -c "source /opt/orcainit5"

# miniconda3 installation

# pip install rdkit, cctk, and morfeus
WORKDIR /tmp
RUN pip install rdkit-pypi cctk morfeus-ml && \
    conda install -c conda-forge xtb && \
    conda install autode --channel conda-forge

USER $USER
WORKDIR /home/$USER
CMD ["tail", "-f", "/dev/null"]


