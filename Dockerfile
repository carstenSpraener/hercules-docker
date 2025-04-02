#
# Start building hercules-hyperion docker image from a debian base
# since it does not need many stuff the slim image should be sufficient
#
# The extra software is installed with apt.
#
FROM debian:stable-slim AS env
ENV DEBIAN_FRONTEND=noninteractive
RUN mkdir /opt/build &&\
    apt-get update &&\
    apt-get -y install git wget zip time &&\
    apt-get -y install build-essential cmake flex gawk m4 autoconf automake libtool-bin libltdl-dev &&\
    apt-get -y install libbz2-dev zlib1g-dev &&\
    apt-get -y install libcap2-bin

# No the environment is set and the build can Start
# copy all the project files into the build directory and Start
# building it.
#
FROM env AS build

WORKDIR /opt/build

RUN git clone https://github.com/SDL-Hercules-390/hyperion.git . &&\
    ./configure &&\
    mkdir /opt/hercules &&\
    make &&\
    make install &&\
    /sbin/ldconfig -v

FROM build as installed

RUN wget https://www.prince-webdesign.nl/images/downloads/mvs-tk5.zip &&\
    unzip mvs-tk5.zip -d /opt/hercules; mv /opt/hercules/mvs-tk5/* /opt/hercules/


#
# With the hercules hyperion build it is no easy to Start
# hercules.
#
# The docker image expects a working area mounted to /opt/hercules
#
# (docker option -v /my/hercules-host-env:/opt/hercules)
#
# and in that directory there must be the configuratiom under conf/herculues.cnf
# The start script inside the hercules console has to be under scripts/ipl.rc
#
#  /my/hercules-host-env
#   .
#   +--conf/hercules.cnf
#   +--scripts/ipl.rc
#
FROM instsalled AS hercules-hyperion
WORKDIR /opt/build

COPY container-start .

# Mount an eventually different HOST environment here
VOLUME /opt/hercules

# These are the ports needed to connect clients to the HOST
EXPOSE 3270
EXPOSE 3278
EXPOSE 8083

CMD ["/bin/bash", "/opt/build/container-start"]