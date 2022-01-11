FROM ubuntu:20.04
LABEL maintainer="Letícia Maria Pequeno Madureira <lmadurei@andrew.cmu.edu>"

# arguments
ARG URL=https://drive.google.com/file/d/1h8iz_dlh5pmLAw6SFr_g-oboFX8OncaT/view?usp=sharing
ARG FILEID=1h8iz_dlh5pmLAw6SFr_g-oboFX8OncaT
ARG NAME=orca_5_0_2_linux_x86-64_shared_openmpi411.tar.xz
ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=America/New_York
ARG PREFIX=/opt
ARG USER=root

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
    wget --quiet https://repo.anaconda.com/miniconda/Miniconda2-4.7.12-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc
# openmpi installation
WORKDIR /tmp
RUN wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.1.tar.gz && \
    tar xvf openmpi-4.1.1.tar.gz && \
    rm openmpi-4.1.1.tar.gz
WORKDIR openmpi-4.1.1
RUN ./configure --prefix=/opt/orca/openmpi-4.1.1 && \
    make all && \
    make install
# orca-5.0.2 installation
WORKDIR $PREFIX
RUN wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1h8iz_dlh5pmLAw6SFr_g-oboFX8OncaT' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1h8iz_dlh5pmLAw6SFr_g-oboFX8OncaT" -O orca.tar.xz && \
    rm -rf /tmp/cookies.txt && \
    tar -xvf orca.tar.xz && \
    rm  orca.tar.xz && \
    rm -rf /var/lib/apt/lists/* && \
    useradd --create-home --shell /bin/bash $USER && \
    echo 'export PATH=$PREFIX/orca:$PATH; export LD_LIBRARY_PATH=$PREFIX/orca:$LD_LIBRARY_PATH' >> /home/$USER/.bashrc && \
    echo 'export PATH=$PREFIX/orca/openmpi-4.1.1/bin:$PATH; export LD_LIBRARY_PATH=$PREFIX/orca/openmpi-4.1.1/lib:$LD_LIBRARY_PATH' >> /home/$USER/.bashrc && \
    /bin/bash -c "source /home/$USER/.bashrc"

# miniconda3 installation

# pip install rdkit, cctk, and morfeus
WORKDIR /tmp
RUN pip install rdkit-pypi cctk morfeus-ml && \
    conda install -c conda-forge xtb && \
    conda install autode --channel conda-forge

USER $USER
WORKDIR /home/$USER
CMD ["tail", "-f", "/dev/null"]


