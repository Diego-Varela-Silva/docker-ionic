FROM ubuntu:18.04
LABEL name="ionic" author="Diego Varela" maintainer="diegovarela.paiva@hotmail.com"

# Install Chrome
RUN echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections \
    && apt-get update \
    && apt-get install -y software-properties-common \
    && apt-add-repository "deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner" \
    && apt-add-repository ppa:malteworld/ppa \
    && apt-get install -y \
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
    xvfb \
    && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && dpkg -i google-chrome-stable_current_amd64.deb \
    && apt-get install -f \
    && rm google-chrome-stable_current_amd64.deb

# Install basic
RUN apt-get install -y sudo zsh

# Configure user
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && useradd --system --uid 1000 --shell /bin/zsh --create-home diego \
    && adduser diego sudo
USER diego
WORKDIR /home/diego

# Install oh-my-zsh
RUN sudo apt-get install -y wget git
ENV TERM xterm
RUN wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | zsh || true
SHELL [ "/bin/zsh", "-i", "-c" ]

# Install asdf
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.4 \
    && echo -e '\n. /home/diego/.asdf/asdf.sh' >> ~/.zshrc \
    && echo -e '\n. /home/diego/.asdf/completions/asdf.bash' >> ~/.zshrc

# Install java-8
RUN sudo apt-get install -y jq curl
RUN asdf plugin-add java \
    && asdf install java amazon-corretto-8.212.04.2 \
    && asdf global java amazon-corretto-8.212.04.2 \
    && echo -e '\n. /home/diego/.asdf/plugins/java/set-java-home.sh' >> ~/.zshrc

# Install nodejs
RUN sudo apt-get install -y gpg
RUN asdf plugin-add nodejs \
    && bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring \
    && asdf install nodejs 10.17.0 \
    && asdf global nodejs 10.17.0
RUN npm install -g cordova@8.1 ionic@4.12 yarn @angular/language-service tslint

# Install gradle
RUN sudo apt-get install -y unzip 
RUN asdf plugin-add gradle \
    && asdf install gradle 4.10.3 \
    && asdf global gradle 4.10.3

# Install android-sdk
ENV ANDROID_SDK_ROOT=/home/diego/android-sdk
ENV PATH=${PATH}:${ANDROID_SDK_ROOT}/tools:${ANDROID_SDK_ROOT}/tools/bin:${ANDROID_SDK_ROOT}/platform-tools
RUN mkdir -p $ANDROID_SDK_ROOT && cd $ANDROID_SDK_ROOT \
    && wget -O tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip \
    && unzip tools.zip && rm tools.zip \
    && yes | sdkmanager --licenses \
    && sdkmanager "platform-tools" "platforms;android-28" "build-tools;28.0.3"

RUN mkdir /home/diego/app
WORKDIR /home/diego/app
CMD "zsh"
