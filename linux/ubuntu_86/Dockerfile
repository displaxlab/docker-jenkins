FROM i386/ubuntu:xenial

LABEL maintainer="taraujo@displax.com"

RUN apt-get update && \
    apt-get install -y \
        gcc g++ build-essential cmake bash libxcb1-dev libicu-dev \
        libssl-dev linux-headers-generic curl git libxrender-dev libnss3-dev libpci-dev \
        libpng3 libpng-dev libjpeg-turbo8 libjpeg-turbo8-dev libicu55 \
        libgles2-mesa libgles2-mesa-dev libfreetype6-dev libsqlite3-dev libgl1-mesa-glx \
	libgstreamer0.10-0 libgstreamer0.10-dev libgl1-mesa-dri libgl1-mesa-dev wget openssh-server \
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
        libdrm-dev libxcb-xfixes0 libxcb-xfixes0-dev libxcb-xkb-dev libxcb-xkb1 libxcb-xprint0 libxcb-xprint0-dev libxcb-xv0 libxcb-xv0-dev libxcb-xvmc0 libxcb-xvmc0-dev libxcb1 libxcb1-dev \
        libxcomposite-dev libxcursor-dev libxdamage-dev libxext-dev libxfixes-dev libxi-dev libxrandr-dev libxrender-dev libxslt-dev libxss-dev libxtst-dev \
        libgnutls30 python python-dev libdbus-1-dev

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs

RUN apt-get clean

# Qt version
ENV QT_VERSION_MAJOR=5.14 QT_VERSION=5.14.1

# Compile and install Qt
ENV QT_DIST /usr/local/Qt/"$QT_VERSION"
ENV QT_BASE_SRC https://download.qt.io/archive/qt/"$QT_VERSION_MAJOR"/"$QT_VERSION"/single/qt-everywhere-src-"$QT_VERSION".tar.xz
ENV QT_BASE_DIR /qt-everywhere-src-"$QT_VERSION"

RUN curl -sSL $QT_BASE_SRC | tar xvJ
RUN cd $QT_BASE_DIR \
    && bash ./configure --help \
    && bash ./configure -prefix $QT_DIST -linker gold -opensource -confirm-license -skip qtwebengine \
       -openssl-linked -qt-pcre -sql-sqlite -sqlite \
       -qt-xcb -nomake examples -nomake tests \
       -qt-doubleconversion -no-glib \
    && make -j4 \
    && make install

# Clean Qt source files
RUN rm -rf QT_BASE_DIR

ENV PATH $QT_DIST/bin:$PATH

# Build linuxdeployqt
RUN cd / && git clone https://github.com/probonopd/linuxdeployqt.git \
    && cd linuxdeployqt \
    && qmake \
    && make \
    && make install \
    && cd / \
    && rm -rf /linuxdeployqt

# Build patchelf
RUN wget https://nixos.org/releases/patchelf/patchelf-0.9/patchelf-0.9.tar.bz2
RUN tar xf patchelf-0.9.tar.bz2
RUN cd patchelf-0.9 && ./configure && make && make install \
    && cd / && rm -rf /patchelf-0.9 \
    && rm patchelf-0.9.tar.bz2
 
# Installer framework
RUN cd / && wget http://download.qt.io/official_releases/qt-installer-framework/2.0.0/qt-installer-framework-opensource-2.0.0-x86.run \
    && chmod a+x qt-installer-framework-opensource-2.0.0-x86.run
COPY qt-installer-framework-noninter.qs /qt-installer-framework-noninteractive.qs
RUN ./qt-installer-framework-opensource-2.0.0-x86.run --platform minimal --verbose --script qt-installer-framework-noninteractive.qs

RUN git clone https://github.com/qbs/qbs.git /qbs \
    && cd /qbs && qmake -r qbs.pro \
    && make && make install

# Add jenkins user
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG JENKINS_AGENT_HOME=/home/${user}
ENV JENKINS_AGENT_HOME=${JENKINS_AGENT_HOME}
RUN groupadd -g ${gid} ${group} \
    && useradd -d "${JENKINS_AGENT_HOME}" -u "${uid}" -g "${gid}" -m -s /bin/bash "${user}"

RUN echo "jenkins:qwerty123" | chpasswd

VOLUME "/tmp"

RUN mkdir /var/run/sshd && \
    chmod 0755 /var/run/sshd && \
    mkdir $JENKINS_AGENT_HOME/workspace && \
    chmod 777 -R $JENKINS_AGENT_HOME/workspace

EXPOSE 22

COPY ./clang-format /usr/local/bin

ENV PATH=$QT_DIST/bin:$PATH QTDIR=$QT_DIST

RUN echo "\n" >> /etc/profile \
    && echo PATH=$PATH >> /etc/profile \
    && echo "\n" >> /etc/profile \
    && echo QTDIR=$QT_DIST >> /etc/profile \
    && echo export PATH >> /etc/profile \
    && echo export QTDIR >> /etc/profile

WORKDIR $JENKINS_AGENT_HOME

CMD ["/usr/sbin/sshd", "-D"]
