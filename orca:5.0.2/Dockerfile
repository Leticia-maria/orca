FROM ubuntu
LABEL maintainer="Letícia Maria Pequeno Madureira <leticiapequeno30@gmail.com>"

# arguments
ARG URL=https://drive.google.com/file/d/1EHqm1MRe6xUBMiZRXWgJM8797zFCPwHv/view?usp=sharing
ARG FILEID=1EHqm1MRe6xUBMiZRXWgJM8797zFCPwHv
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
    apt install --yes python python3-pip git wget htop && \
# miniconda installation
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    mkdir /root/.conda && \
    bash Miniconda3-latest-Linux-x86_64.sh -b && \
    rm -f Miniconda3-latest-Linux-x86_64.sh && \
    rm -rf /var/lib/apt/lists/* && \
# orca-5.0.2 installation
    wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1EHqm1MRe6xUBMiZRXWgJM8797zFCPwHv' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1EHqm1MRe6xUBMiZRXWgJM8797zFCPwHv" -O orca-5.0.2.tar.xz && \
    rm -rf /tmp/cookies.txt && \
    tar -xvf orca-5.0.2.tar.xz && \
    rm  orca-5.0.2.tar.xz
WORKDIR /tmp
RUN wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.1.tar.gz && \
    tar xvf openmpi-4.1.1.tar.gz && \
    rm openmpi-4.1.1.tar.gz
WORKDIR /tmp/openmpi-4.1.1
RUN ./configure --prefix=/opt/orca-5.0.2/openmpi-4.1.1 && \
    make all && \
    make install && \
    git clone https://github.com/Leticia-maria/orca.git
WORKDIR $PREFIX
RUN wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1sYen1Pu7fiAqU5lsz87_B3mOc5jfUnOC' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1sYen1Pu7fiAqU5lsz87_B3mOc5jfUnOC" -O nbo7.tar.xz && \
    wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1lNmIAg4UEe92blgJlpxF-F-R8bMa9uoU' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1lNmIAg4UEe92blgJlpxF-F-R8bMa9uoU" -O orcainit5 && \
    rm -rf /tmp/cookies.txt && \
    tar -xvf nbo7.tar.xz && \
    rm -rf nbo7.tar.xz && \
    useradd --create-home --shell /bin/bash $USER && \
    echo 'source /opt/orcainit5' >> /home/$USER/.bashrc && \
    /bin/bash -c "source /home/$USER/.bashrc"
# pip install rdkit, cctk, and morfeus
WORKDIR /tmp
RUN pip install rdkit-pypi cctk morfeus-ml rich rich-cli && \
    conda install -c conda-forge xtb autode crest && \
    apt-get remove --yes wget
WORKDIR $PREFIX/orca-5.0.2
    RUN ln -s $(which xtb) otool_xtb

USER $USER
WORKDIR /home/$USER
CMD ["tail", "-f", "/dev/null"]
