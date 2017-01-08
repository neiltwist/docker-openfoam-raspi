FROM resin/rpi-raspbian

RUN apt-get update && apt-get upgrade && apt-get install wget

RUN mkdir ~/mpich2 && mkdir ~/mpich2/build && mkdir /opt/mpich2
RUN cd ~/mpich2 && wget http://www.mcs.anl.gov/research/projects/mpich2/downloads/tarballs/1.4.1p1/mpich2-1.4.1p1.tar.gz && tar xf mpich2-1.4.1p1.tar.gz

RUN apt-get install build-essential gfortran

RUN cd ~/mpich2/build && ~/mpich2/mpich2-1.4.1p1/configure -prefix=/opt/mpich2
RUN cd ~/mpich2/build && make && make install

RUN mkdir ~/OpenFOAM && mkdir /opt/OpenFOAM

RUN cd ~/OpenFOAM && wget https://github.com/OpenFOAM/OpenFOAM-dev/archive/master.zip

RUN apt-get install unzip

RUN cd ~/OpenFOAM && unzip master.zip

RUN ls ~/OpenFOAM/ && ./AllMake
