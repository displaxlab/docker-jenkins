FROM ubuntu:16.04

LABEL maintainer="taraujo@displax.com"

RUN apt-get update && apt-get install -y \
    x11vnc xauth mesa-common-dev libxkbcommon-dev libxcb-xvmc0 libxcb-xvmc0-dev \
    libxslt1-dev libgstreamer-plugins-base0.10-dev libxcb1 libxcb1-dev \    
    gcc build-essential cmake bash libxcb1-dev libicu-dev \
    libssl-dev linux-headers-generic curl git libxrender-dev libnss3-dev libpci-dev \
    libpng3 libpng-dev libjpeg-turbo8 libjpeg-turbo8-dev libicu55 \
    libgles2-mesa libgles2-mesa-dev libfreetype6-dev libsqlite3-dev libgl1-mesa-glx \
    libgstreamer0.10-0 libgstreamer0.10-dev libgl1-mesa-dri g++ libgl1-mesa-dev wget openssh-server \
    libogg-dev libvorbis-dev bzip2 gperf bison ruby flex openjdk-8-jdk \
    libudev-dev libudev1 libusb-1.0-0-dev libusb-1.0-0 libhidapi-hidraw0 libhidapi-dev \
    ibgstreamer-plugins-base0.10-dev libasound2-dev libatkmm-1.6-dev libbz2-dev libcap-dev libcups2-dev \
    libfontconfig1-dev libgcrypt11-dev libglu1-mesa-dev libpulse-dev libx11-dev libx11-xcb-dev \
    libxcb-composite0 libxcb-composite0-dev libxcb-cursor-dev libxcb-cursor0 libxcb-damage0 libxcb-damage0-dev libxcb-dpms0 \
    libxcb-dpms0-dev libxcb-dri2-0 libxcb-dri2-0-dev libxcb-dri3-0 libxcb-dri3-dev libxcb-ewmh-dev libxcb-ewmh2 \
    libxcb-glx0 libxcb-glx0-dev libxcb-icccm4 libxcb-icccm4-dev libxcb-image0 libxcb-image0-dev libxcb-keysyms1 libxcb-keysyms1-dev libxcb-present-dev \
    libxcb-present0 libxcb-randr0 libxcb-randr0-dev libxcb-record0 libxcb-record0-dev libxcb-render-util0 libxcb-render-util0-dev \
    libxcb-screensaver0 libxcb-screensaver0-dev libxcb-shape0 libxcb-shape0-dev libxcb-shm0 libxcb-shm0-dev libxcb-sync-dev libxcb-sync0-dev \
    libxcb-render0 libxcb-render0-dev libxcb-res0 libxcb-res0-dev \
    libxcb-sync1 libxcb-util-dev libxcb-util0-dev libxcb-util1 libxcb-xevie0 libxcb-xevie0-dev libxcb-xf86dri0 libxcb-xf86dri0-dev  \
    libdrm-dev libxcb-xfixes0 libxcb-xfixes0-dev libxcb-xkb-dev libxcb-xkb1 libxcb-xprint0 libxcb-xprint0-dev libxcb-xv0 libxcb-xv0-dev \
    libxcomposite-dev libxcursor-dev libxdamage-dev libxext-dev libxfixes-dev libxi-dev libxrandr-dev libxrender-dev libxslt-dev libxss-dev libxtst-dev \
    libdbus-1-dev libdbus-glib-1-dev libgnutls30 python python-dev

# Download and install node
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y nodejs

RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test && apt-get update && apt-get install -y gcc-8 g++-8
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8

ARG user=jenkins
ARG group=jenkins
ARG uid=1000 
ARG gid=1000 
ARG JENKINS_AGENT_HOME=/home/${user} 
ENV JENKINS_AGENT_HOME ${JENKINS_AGENT_HOME} 
RUN groupadd -g ${gid} ${group} \
    && useradd -d "${JENKINS_AGENT_HOME}" -u "${uid}" -g "${gid}" -m -s /bin/bash "${user}"

RUN echo "jenkins:qwerty123" | chpasswd

VOLUME "/tmp" 

ENV QT_VERSION=5.11.2 ANDROID_COMPILER=android_armv7

RUN mkdir /var/run/sshd && \
    mkdir $JENKINS_AGENT_HOME/Qt && \
    chmod 777 -R $JENKINS_AGENT_HOME/Qt && \
    mkdir $JENKINS_AGENT_HOME/workspace && \
    chmod 777 -R $JENKINS_AGENT_HOME/workspace

# Download QT installer
RUN cd / && wget http://download.qt.io/official_releases/online_installers/qt-unified-linux-x64-online.run
COPY qt-installer-noninteractive.qs /qt-installer-noninteractive.qs

# Install QT
RUN chmod a+x qt-unified-linux-x64-online.run
RUN ./qt-unified-linux-x64-online.run --platform minimal --verbose --script qt-installer-noninteractive.qs

EXPOSE 22

ENV QTDIR "${JENKINS_AGENT_HOME}/Qt/${QT_VERSION}/${ANDROID_COMPILER}"
ENV PATH $QTDIR/bin:"${JENKINS_AGENT_HOME}/Qt/Tools/QtCreator/bin":$PATH

COPY ./clang-format /usr/local/bin

WORKDIR $JENKINS_AGENT_HOME

CMD ["/usr/sbin/sshd", "-D"]

# Android
# Install Dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y libncurses5:i386 libstdc++6:i386 zlib1g:i386

# Install java8
RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer && apt-get clean

# Java Environment
ENV JAVA8_HOME=/usr/lib/jvm/java-8-oracle JAVA_HOME=$JAVA8_HOME PATH=$PATH:$JAVA_HOME/bin

# Download Android SDK tools
RUN wget -q "http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz" -O android-sdk.tgz && \
    tar -xzf android-sdk.tgz -C /opt && \
    rm android-sdk.tgz

# Android SDK Environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/tools/bin
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$ANDROID_HOME/build-tools/24.0.3

# Install Android SDK components
RUN echo y | android update sdk --no-ui --all --filter \
    "platform-tools,build-tools-28.0.2,android-22,android-24,android-25,android-26,android-27" && \
    echo y | android update sdk --no-ui --all --filter \
    "extra-android-m2repository,extra-google-m2repository,extra-android-support"

# Install Android NDK
RUN cd /opt && wget --output-document=android-ndk.zip \
    --quiet http://dl.google.com/android/repository/android-ndk-r17c-linux-x86_64.zip && \
unzip -q android-ndk.zip && rm -f android-ndk.zip

# Android environment
ENV ANDROID_NDK_HOME /opt/android-ndk-r17c
ENV ANDROID_NDK_ROOT /opt/android-ndk-r17c
ENV ANDROID_NDK_HOST linux-x86_64
ENV ANDROID_NDK_PLATFORM android-22
ENV ANDROID_NDK_TOOLCHAIN_PREFIX arm-linux-androideabi
ENV ANDROID_NDK_TOOLCHAIN_VERSION 4.9
ENV ANDROID_NDK_TOOLS_PREFIX arm-linux-androideabi
ENV ANDROID_SDK_ROOT $ANDROID_HOME
ENV NDK $ANDROID_NDK_ROOT

# Setup Gradle
ENV GRADLE_VERSION 3.4
RUN wget -q "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -O gradle.zip && \
    unzip -q gradle.zip -d /opt && \
    ln -s "/opt/gradle-${GRADLE_VERSION}/bin/gradle" /usr/bin/gradle && \
    rm gradle.zip

# Gradle Environment
ENV GRADLE_HOME /opt/gradle-${GRADLE_VERSION}
ENV PATH $PATH:$GRADLE_HOME/bin:ANDROID_NDK_HOME
ENV GRADLE_USER_HOME "${JENKINS_AGENT_HOME}/.gradle"

RUN echo "\n" >> /etc/profile \
&& echo PATH=$PATH >> /etc/profile \
&& echo "\n" >> /etc/profile \
&& echo QTDIR=$QTDIR >> /etc/profile \
&& echo ANDROID_HOME=$ANDROID_HOME >> /etc/profile \
&& echo JAVA_HOME=$JAVA_HOME >> /etc/profile \
&& echo ANDROID_NDK_HOME=$ANDROID_NDK_HOME >> /etc/profile \
&& echo ANDROID_NDK_ROOT=$ANDROID_NDK_ROOT >> /etc/profile \
&& echo ANDROID_NDK_HOST=$ANDROID_NDK_HOST >> /etc/profile \
&& echo ANDROID_NDK_PLATFORM=$ANDROID_NDK_PLATFORM >> /etc/profile \
&& echo ANDROID_NDK_TOOLCHAIN_PREFIX=$ANDROID_NDK_TOOLCHAIN_PREFIX >> /etc/profile \
&& echo ANDROID_NDK_TOOLCHAIN_VERSION=$ANDROID_NDK_TOOLCHAIN_VERSION >> /etc/profile \
&& echo ANDROID_NDK_TOOLS_PREFIX=$ANDROID_NDK_TOOLS_PREFIX >> /etc/profile \
&& echo ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT >> /etc/profile \
&& echo NDK=$NDK >> /etc/profile \
&& echo export PATH >> /etc/profile \
&& echo export ANDROID_HOME >> /etc/profile \
&& echo export JAVA_HOME >> /etc/profile \
&& echo export ANDROID_NDK_HOME >> /etc/profile \
&& echo export ANDROID_NDK_ROOT >> /etc/profile \
&& echo export ANDROID_NDK_HOST >> /etc/profile \
&& echo export ANDROID_NDK_PLATFORM >> /etc/profile \
&& echo export ANDROID_NDK_TOOLCHAIN_PREFIX >> /etc/profile \
&& echo export ANDROID_NDK_TOOLCHAIN_VERSION >> /etc/profile \
&& echo export ANDROID_NDK_TOOLS_PREFIX >> /etc/profile \
&& echo export ANDROID_SDK_ROOT >> /etc/profile \
&& echo export NDK >> /etc/profile
