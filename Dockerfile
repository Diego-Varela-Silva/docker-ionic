FROM ubuntu:18.04
LABEL name="ionic" author="Diego Varela" version="4.12.0" maintainer="diegovarela.paiva@hotmail.com"

# Update
RUN apt-get update

# Install java
ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
RUN apt-get install -y openjdk-8-jdk

# Install basics
RUN apt-get install -y git wget curl unzip build-essential ruby ruby-dev ruby-ffi gcc make

# Install node
ENV NODE_VERSION=10.15.3
RUN curl --retry 3 -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" && \
    tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 && \
    rm "node-v$NODE_VERSION-linux-x64.tar.gz"

# Update NPM
ENV NPM_VERSION=6.9.0
RUN npm install -g npm@"$NPM_VERSION"

# Install ionic and cordova
ENV CORDOVA_VERSION=8.1.2 IONIC_VERSION=4.12.0
RUN npm install -g cordova@"$CORDOVA_VERSION" ionic@"$IONIC_VERSION"

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

RUN mkdir myApp
WORKDIR /myApp
EXPOSE 8100 35729
