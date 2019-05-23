FROM ubuntu

#ADD SOME NEEDED DEPENDENCIES
RUN apt-get update && apt-get install -y \
   nano \
   software-properties-common \
   wget

#INSTALL JAVA JRE 1.8
RUN add-apt-repository ppa:webupd8team/java
RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN apt-get update && apt-get install -y oracle-java8-installer

#SET WORKING DIRECTORY
WORKDIR /home

#GET IESI RELEASE
RUN wget https://github.com/metadew/iesi/releases/download/v0.0.4/iesi-dist-0.0.4.tar.gz && tar -xvzf iesi-dist-0.0.4.tar.gz

#CREATE REPOSITORY CONFIG
COPY config/conf/iesi-repository.conf iesi/conf/iesi-repository.conf

#CREATE METADATA REPOSITORY
RUN cd iesi/bin && ./iesi-metadata.sh -create -type general