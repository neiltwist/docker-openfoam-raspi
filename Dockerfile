FROM resin/rpi-raspbian

RUN apt-get update && apt-get upgrade && apt-get install wget

#RUN mkdir ~/mpich2 && mkdir ~/mpich2/build && mkdir /opt/mpich2
#RUN cd ~/mpich2 && wget http://www.mcs.anl.gov/research/projects/mpich2/downloads/tarballs/1.4.1p1/mpich2-1.4.1p1.tar.gz && tar xf mpich2-1.4.1p1.tar.gz

RUN apt-get install build-essential gfortran

#RUN cd ~/mpich2/build && ~/mpich2/mpich2-1.4.1p1/configure -prefix=/opt/mpich2
#RUN cd ~/mpich2/build && make && make install

RUN mkdir ~/OpenFOAM && mkdir /opt/OpenFOAM

#RUN cd ~/OpenFOAM && wget https://github.com/OpenFOAM/OpenFOAM-dev/archive/master.zip

#RUN apt-get install unzip

#RUN cd ~/OpenFOAM && unzip master.zip && mv OpenFOAM-dev-master OpenFOAM-dev

#RUN apt-get install flex bison git-core cmake zlib1g-dev libboost-system-dev libboost-thread-dev libopenmpi-dev openmpi-bin gnuplot libreadline-dev libncurses-dev libxt-dev

#RUN apt-get install libc6-dev

RUN apt-get install git-core build-essential binutils-dev cmake flex bison zlib1g-dev qt4-dev-tools libqt4-dev libqtwebkit-dev gnuplot \
libreadline-dev libncurses-dev libxt-dev libopenmpi-dev openmpi-bin libboost-system-dev libboost-thread-dev libgmp-dev \
libmpfr-dev python python-dev  freeglut3-dev mesa-common-dev

RUN /bin/bash -c "cd ~/OpenFOAM; \
git clone https://github.com/OpenFOAM/OpenFOAM-dev.git; \
git clone https://github.com/OpenFOAM/ThirdParty-dev.git; \
cd ThirdParty-dev; \
mkdir download; \
wget -P download https://github.com/CGAL/cgal/releases/download/releases%2FCGAL-4.8.1/CGAL-4.8.1.tar.xz; \
tar -xJf download/CGAL-4.8.1.tar.xz; \
cd ..; \
#ls -l OpenFOAM-dev/etc/config.sh; \
sed -i -e 's/\(cgal_version=\)cgal-system/\1CGAL-4.8.1/' OpenFOAM-dev/etc/config.sh/CGAL; \
sed -i -e '/softfp/ s/^/#/'  -e '/hard/ s/^#//' OpenFOAM-dev/wmake/rules/linuxARM7Gcc/{cOpt,c++Opt}; \
source $HOME/OpenFOAM/OpenFOAM-dev/etc/bashrc FOAMY_HEX_MESH=yes; \
cd $WM_THIRD_PARTY_DIR ;\
\ 
#make very certain that the correct Qt version is being used, by running this command:\
export QT_SELECT=qt4;\
\ 
# This next command will take a while... somewhere between 5 minutes to 30 minutes.\
./Allwmake > log.make 2>&1;\
\ 
#update the shell environment\
wmRefresh;"

#RUN /bin/bash -c 'source ~/OpenFOAM/OpenFOAM-dev/etc/bashrc && cd $WM_PROJECT_DIR && ./Allwmake'
