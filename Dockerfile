FROM centos:7.5.1804

RUN yum -y install java-1.8.0-openjdk less && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    echo OK

RUN yum -y install wget less && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    echo OK

#SET WORKING DIRECTORY
WORKDIR /home

#GET IESI RELEASE
RUN wget https://github.com/metadew/iesi/releases/download/v0.0.4/iesi-dist-0.0.4.tar.gz && tar -xvzf iesi-dist-0.0.4.tar.gz

#CREATE REPOSITORY CONFIG
COPY config/conf/iesi-repository.conf iesi/conf/iesi-repository.conf

#CREATE METADATA REPOSITORY
RUN cd iesi/bin && ./iesi-metadata.sh -create -type general