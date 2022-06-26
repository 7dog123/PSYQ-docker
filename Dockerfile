FROM ubuntu:20.04

ENV WINEDEBUG -all
ENV C_INCLUDE_PATH ~/.wine/drive_c/psyq/include
ENV C_PLUS_INCLUDE_PATH ~/.wine/drive_c/psyq/include
ENV COMPILER_PATH ~/.wine/drive_c/psyq/bin
ENV G032TMP ~/.wine/drive_c/tempdir
ENV GO32 "DPMISTACK 1000000"
ENV LIBRARY_PATH ~/.wine/drive_c/psyq/lib
ENV PSX_PATH ~/.wine/drive_c/psyq/bin
ENV PSYQ_PATH ~/.wine/drive_c/psyq/bin
ENV TMPDIR ~/.wine/drive_c/tmpdir
ENV PATH $PATH:~/.wine/drive_c/psyq/bin$PATH

RUN dpkg --add-architecture i386
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive TZ=US/Central \
    apt-get install -y git wine build-essential \
    libtinyxml2-dev cmake wget wine32 dosbox unzip
RUN apt-get clean

WORKDIR /usr/local/src

RUN wget https://psx.arthus.net/sdk/Psy-Q/PSYQ_SDK.zip

RUN winecfg

RUN unzip PSYQ_SDK.zip -d ~/.wine/drive_c

RUN cp ~/.wine/drive_c/psyq/bin/CPE2X.EXE ~/.wine/drive_c/psyq/bin/CPE2X.EXE.BAK && \
    wget -o ~/.wine/drive_c/psyq/bin/CPE2X.EXE https://github.com/7dog123/PSXDOOM-RE/raw/master/PSYQ/CPE2X.EXE && \
    wget -o ~/.wine/drive_c/psyq/bin/cpe2x_gec.exe https://github.com/7dog123/PSXDOOM-RE/raw/master/PSYQ/cpe2x_gec.exe

