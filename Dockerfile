FROM teeks99/boost-cpp-docker:gcc-8

# Install required packages
RUN apt-get update && apt-get install -y \
    libxkbfile1 libsecret-1-0 libnotify4 libgconf-2-4 libnss3 libgtk2.0-0 libxss1 \
    libgconf-2-4 libasound2 libxtst6 libcanberra-gtk-dev libgl1-mesa-glx libgl1-mesa-dri \
    ninja-build gdb ant

# Compile & Install CMake latest release
RUN git clone --single-branch --branch release https://github.com/Kitware/CMake.git && \
    cd CMake; \
    ./bootstrap && \
    make -j4 && \
    make install && \
    cd ..; rm -R CMake


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

# Environment variables
ENV DISPLAY=:0.0
ENV VS_OPTIONS=""

CMD [ "/bin/bash", "-c",  "code ${VS_OPTIONS} --verbose --disable-gpu -n ." ]
