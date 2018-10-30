FROM microsoft/dotnet
MAINTAINER oelhiraika@gmail.com

ENV DOCFX_VER 2.40.1

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \ 
 && echo "deb http://download.mono-project.com/repo/debian wheezy main" | tee /etc/apt/sources.list.d/mono-xamarin.list \ 
 && echo "deb http://download.mono-project.com/repo/debian wheezy-apache24-compat main" | tee -a /etc/apt/sources.list.d/mono-xamarin.list \ 
 && echo "deb http://download.mono-project.com/repo/debian wheezy-libjpeg62-compat main" | tee -a /etc/apt/sources.list.d/mono-xamarin.list \ 
 && apt-get update && apt-get upgrade -y

RUN apt-get update && apt-get install -y --fix-missing mono-complete nuget

RUN apt-get update && apt-get install unzip wget git -y && \
    wget -q -P /tmp https://github.com/dotnet/docfx/releases/download/v${DOCFX_VER}/docfx.zip && \
    mkdir -p /opt/docfx && \
    unzip /tmp/docfx.zip -d /opt/docfx && \
    echo '#!/bin/bash\nmono /opt/docfx/docfx.exe $@' > /usr/bin/docfx && \
    chmod +x /usr/bin/docfx && \
		rm -f /tmp/*

