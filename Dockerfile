FROM ubuntu:24.04

RUN apt-get update
RUN apt-get install -y wget zip
RUN mkdir /azcopy
WORKDIR /azcopy
RUN wget https://aka.ms/downloadazcopy-v10-linux
RUN tar -xf downloadazcopy-v10-linux
RUN rm downloadazcopy-v10-linux
RUN mv $(ls)/azcopy /usr/bin/azcopy 
WORKDIR /
RUN rm -rf /azcopy

RUN mkdir /data

ENV AZURE_STORAGE_ACCOUNT=""
ENV AZURE_STORAGE_ACCOUNT_CONTAINER=""
ENV AZURE_STORAGE_SAS_TOKEN=""

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
