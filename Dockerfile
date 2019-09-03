FROM rocker/tidyverse:latest

WORKDIR /tmp

RUN mv /etc/apt/sources.list /etc/apt/sources.list.backup
COPY tuna.source.list /etc/apt/sources.list
RUN apt-get upgrade -y & apt-get update

# R
RUN install2.r --error \
      --deps TRUE \
      WaveletComp \
      pacman \
      JuliaCall

# MATLAB
RUN apt-get install -y --no-install-recommends \
      libpng-dev libfreetype6-dev libxt6\
      libblas-dev liblapack-dev gfortran build-essential
#xorg 

# Julia
RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.1/julia-1.1.1-linux-x86_64.tar.gz -O julia.tar.gz && \
    tar -zxvf julia.tar.gz -C /usr/local/ && \
    rm julia.tar.gz
RUN apt-get install -y --no-install-recommends \
      llvm-dev
ENV JULIA_DEPOT_PATH /usr/local/julia-1.1.1/local/share/julia
COPY install2.jl /usr/bin/
RUN chmod +x /usr/bin/install2.jl
RUN install2.jl FFTW StatsKit CSV RCall RData Glob DataFrames Parameters JLD Suppressor MultivariateStats Statistics Loess
RUN chmod -R ugo+r+x /usr/local/julia-1.1.1  

RUN echo "export PATH=/usr/local/julia-1.1.1/bin:/usr/local/MATLAB/from-host/bin:$PATH" >> /etc/profile.d/powerData.sh

#Python
# RUN apt-get install -y --no-install-recommends \ 
#       build-essential zlib1g-dev \
#       libncurses5-dev libgdbm-dev libnss3-dev \
#       libssl-dev libreadline-dev libffi-dev

# RUN N wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tar.xz
# RUN tar -xf Python-3.7.4.tar.xz
# RUN cd Python-3.7.4 && ./configure --enable-optimizations && make && make altinstall
# RUN wget https://bootstrap.pypa.io/get-pip.py && python3.7 ./get-pip.py

# Jupyter
#RUN apt-get install -y --no-install-recommends \
#      python3-pip python3-setuptools

# RUN python3.7 -m pip install jupyterlab

# Supervisor
# RUN apt-get install -y --no-install-recommends \
#      supervisor
#RUN mkdir -p /var/log/supervisor

#COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#CMD ["/usr/bin/supervisord"]
