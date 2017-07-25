FROM 0x6c7862/afl-fuzz:latest

RUN dpkg --add-architecture i386 \
  && DEBIAN_FRONTEND=noninteractive apt-get update -y \ 
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    --no-install-suggests \
    libini-config-dev  	\ 
    libc6-dev:i386  \
    gcc-multilib \
    libreadline-dev:i386 \
    cabextract \
  && cd /usr/local/src \
  && git clone --depth=1 https://github.com/taviso/loadlibrary.git \
  && cd loadlibrary \
  && make \
  && cd engine \
  && wget "https://go.microsoft.com/fwlink/?LinkID=121721&arch=x86" -O mpam-fe.exe \
  && cabextract mpam-fe.exe \
  && apt-get clean -y \ 
  && rm -rf /var/lib/apt/lists/*
