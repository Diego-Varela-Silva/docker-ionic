FROM ubuntu:18.04
LABEL name="ionic" author="Diego Varela" maintainer="diegovarela.paiva@hotmail.com"

# Install basics
ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
RUN apt-get update && apt-get install -y openjdk-8-jdk git wget curl unzip build-essential ruby ruby-dev ruby-ffi \
    gcc make pkg-config meson ninja-build libavcodec-dev libavformat-dev libavutil-dev libsdl2-dev zsh nano vim

# Install node
ENV NODE_VERSION=10.15.3
RUN curl --retry 3 -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" && \
    tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 && \
    rm "node-v$NODE_VERSION-linux-x64.tar.gz"

# Update NPM
ENV NPM_VERSION=6.9.0
RUN npm install -g npm@"$NPM_VERSION"

# Install ionic dev dependencies
ENV CORDOVA_VERSION=8.1.2 IONIC_VERSION=4.12.0 YARN=1.16.0
RUN npm install -g cordova@"$CORDOVA_VERSION" ionic@"$IONIC_VERSION" YARN@"$YARN" @angular/language-service@7.1

# Install Gradle
ENV GRADLE_VERSION=5.4.1
ENV PATH=${PATH}:/opt/gradle/gradle-"$GRADLE_VERSION"/bin
RUN wget https://services.gradle.org/distributions/gradle-"$GRADLE_VERSION"-bin.zip && \
    mkdir /opt/gradle && \
    unzip -d /opt/gradle gradle-"$GRADLE_VERSION"-bin.zip && \
    rm -rf gradle-"$GRADLE_VERSION"-bin.zip

# Install Android SDK
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV PATH=${PATH}:${ANDROID_SDK_ROOT}/tools:${ANDROID_SDK_ROOT}/tools/bin:${ANDROID_SDK_ROOT}/platform-tools
RUN mkdir -p $ANDROID_SDK_ROOT && cd $ANDROID_SDK_ROOT && \
    wget -O tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
    unzip tools.zip && rm tools.zip && \
    yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" "platforms;android-28" "build-tools;28.0.3" && \
    chmod a+x -R $ANDROID_SDK_ROOT && \
    chown -R root:root $ANDROID_SDK_ROOT && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoremove -y && \
    apt-get clean

# Install Scrcpy
ENV SCRCPY_VER=1.8
RUN cd /opt && git clone https://github.com/Genymobile/scrcpy && \
    cd scrcpy && \
    curl -L -o scrcpy-server.jar https://github.com/Genymobile/scrcpy/releases/download/v${SCRCPY_VER}/scrcpy-server-v${SCRCPY_VER}.jar && \
    meson x --buildtype release --strip -Db_lto=true -Dprebuilt_server=scrcpy-server.jar && \
    cd x && ninja && ninja install && \
    rm -rf /opt/scrcpy

# Install Chrome
RUN apt-get update && \
    echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections && \
    apt-get install -y software-properties-common &&\
    apt-add-repository "deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner" && \
    apt-add-repository ppa:malteworld/ppa && apt-get update && apt-get install -y \
    adobe-flashplugin \
    msttcorefonts \
    fonts-noto-color-emoji \
    fonts-noto-cjk \
    fonts-liberation \
    fonts-thai-tlwg \
    fontconfig \
    libappindicator3-1 \
    pdftk \
    unzip \
    locales \
    gconf-service \
    libasound2 \
    libatk1.0-0 \
    libc6 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgcc1 \
    libgconf-2-4 \
    libgdk-pixbuf2.0-0 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    ca-certificates \
    libappindicator1 \
    libnss3 \
    lsb-release \
    xdg-utils \
    xvfb && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb && apt-get install -f && \
    rm google-chrome-stable_current_amd64.deb

RUN mkdir myApp
WORKDIR /myApp
