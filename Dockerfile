FROM debian:stretch-slim

# ensure java is installed properly
RUN mkdir -p /usr/share/man/man1


RUN apt-get update && \
    apt-get install -y \
      ca-certificates \
      build-essential \
      gcc-multilib g++-multilib \
      ninja-build \
      gdb \
      cmake \
      openjdk-8-jdk \
      ant \
      git \
      doxygen \
      wget \
      curl \
      nano

# Environment variables
ENV DISPLAY=:0.0
ENV VS_OPTIONS=""

# ADD jsch package to the ANT
ENV ANT_HOME=/usr/share/ant
RUN wget -O ${ANT_HOME}/jsch-latest.jar https://sourceforge.net/projects/jsch/files/latest/download

# Install visual studio code
RUN wget https://go.microsoft.com/fwlink/?LinkID=760868 -O vscode.deb && \
    dpkg -i vscode.deb; \
    apt-get -f install -y && \
    rm vscode.deb && \
    rm -rf /var/lib/apt/lists/*


RUN useradd -m vscode -s /bin/bash
WORKDIR /src
USER vscode

RUN code --install-extension ms-vscode.cpptools
RUN code --install-extension vector-of-bool.cmake-tools
RUN code --install-extension go2sh.cmake-integration-vscode
RUN code --install-extension eamodio.gitlens
RUN code --install-extension twxs.cmake
RUN code --install-extension cschlosser.doxdocgen
RUN code --install-extension spmeesseman.vscode-taskexplorer
RUN code --install-extension mutantdino.resourcemonitor


CMD [ "/bin/bash", "-c",  "code ${VS_OPTIONS} --verbose --disable-gpu -n ." ]
