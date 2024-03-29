FROM i386/ubuntu:xenial

# Install core dependencies
RUN apt-get update && \
    apt-get install -y \
        gcc g++ build-essential cmake bash libxcb1-dev libicu-dev \
        libssl-dev linux-headers-generic curl git libxrender-dev libnss3-dev libpci-dev \
        libpng16-dev libjpeg-turbo8 libjpeg-turbo8-dev libicu55 \
        libgles2-mesa libgles2-mesa-dev libsqlite3-dev libgl1-mesa-glx \
	libgstreamer0.10-0 libgstreamer0.10-dev libgl1-mesa-dri libgl1-mesa-dev wget openssh-server \
        libogg-dev libvorbis-dev bzip2 gperf bison ruby flex openjdk-8-jdk \
        libudev-dev libudev1 libusb-1.0-0-dev libusb-1.0-0 libhidapi-hidraw0 libhidapi-dev \
        ibgstreamer-plugins-base0.10-dev libasound2-dev libatkmm-1.6-dev libbz2-dev libcap-dev libcups2-dev \
        libgcrypt11-dev libglu1-mesa-dev libpulse-dev libx11-dev libx11-xcb-dev \
        libxcb-composite0 libxcb-composite0-dev libxcb-cursor-dev libxcb-cursor0 libxcb-damage0 libxcb-damage0-dev libxcb-dpms0 \
        libxcb-dpms0-dev libxcb-dri2-0 libxcb-dri2-0-dev libxcb-dri3-0 libxcb-dri3-dev libxcb-ewmh-dev libxcb-ewmh2 \
        libxcb-glx0 libxcb-glx0-dev libxcb-icccm4 libxcb-icccm4-dev libxcb-image0 libxcb-image0-dev libxcb-keysyms1 libxcb-keysyms1-dev libxcb-present-dev \
        libxcb-present0 libxcb-randr0 libxcb-randr0-dev libxcb-record0 libxcb-record0-dev libxcb-render-util0 libxcb-render-util0-dev \
        libxcb-screensaver0 libxcb-screensaver0-dev libxcb-shape0 libxcb-shape0-dev libxcb-shm0 libxcb-shm0-dev libxcb-sync-dev libxcb-sync0-dev \
        libxcb-render0 libxcb-render0-dev libxcb-res0 libxcb-res0-dev \
        libxcb-sync1 libxcb-util-dev libxcb-util0-dev libxcb-util1 libxcb-xevie0 libxcb-xevie0-dev libxcb-xf86dri0 libxcb-xf86dri0-dev  \
        libdrm-dev libxcb-xfixes0 libxcb-xfixes0-dev libxcb-xkb-dev libxcb-xkb1 libxcb-xprint0 libxcb-xprint0-dev libxcb-xv0 libxcb-xv0-dev libxcb-xvmc0 libxcb-xvmc0-dev libxcb1 libxcb1-dev \
        libxcomposite-dev libxcursor-dev libxdamage-dev libxext-dev libxfixes-dev libxi-dev libxrandr-dev libxrender-dev libxslt-dev libxss-dev libxtst-dev \
        libgnutls30 python python-dev

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test && apt-get update && apt-get install -y gcc-8 g++-8
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8

# Choose Qt version
ENV QT_VERSION_MAJOR 5.12
ENV QT_VERSION 5.12.0

# Compile and install Qt
ENV QT_DIST /usr/local/Qt/"$QT_VERSION"
ENV QT_BASE_SRC https://download.qt.io/archive/qt/"$QT_VERSION_MAJOR"/"$QT_VERSION"/single/qt-everywhere-src-"$QT_VERSION".tar.xz
ENV QT_BASE_DIR /qt-everywhere-src-"$QT_VERSION"

RUN curl -sSL $QT_BASE_SRC | tar xvJ
RUN cd $QT_BASE_DIR \
    && bash ./configure --help \
    && bash ./configure -prefix $QT_DIST -no-use-gold-linker -opensource -confirm-license \
       -openssl-linked -qt-pcre -sql-sqlite -sqlite \
       -qt-xcb -nomake examples -nomake tests \
       -qt-doubleconversion -no-glib \
    && make -j4 \
    && make install

# Clean Qt source files
RUN rm -rf QT_BASE_DIR

# linuxdeployqt
RUN cd / && git clone https://github.com/probonopd/linuxdeployqt.git

ENV PATH $QT_DIST/bin:$PATH

# Build linuxdeployqt
RUN cd linuxdeployqt && qmake && make && make install

# Remove linuxdeployqt source
RUN cd / && rm -rf /linuxdeployqt

# Build and build patchelf
RUN cd / && wget https://nixos.org/releases/patchelf/patchelf-0.9/patchelf-0.9.tar.bz2
RUN tar xf patchelf-0.9.tar.bz2
RUN cd patchelf-0.9 && ./configure && make && make install

# Remove patchelf source
RUN cd / && rm -rf /patchelf-0.9 && rm patchelf-0.9.tar.bz2
 
# TODO: install installer framework by script and remove the above step
# RUN cd / && wget http://download.qt.io/official_releases/qt-installer-framework/2.0.0/qt-installer-framework-opensource-2.0.0-x86.run
# RUN chmod a+x qt-installer-framework-opensource-2.0.0-x86.run
# COPY qt-installer-framework-noninteractive.qs /qt-installer-framework-noninteractive.qs
# RUN ./qt-installer-framework-opensource-2.0.0-x86.run --platform minimal --verbose --script qt-installer-framework-noninteractive.qs

RUN git clone https://github.com/qbs/qbs.git /qbs
RUN cd /qbs && qmake -r qbs.pro && make && make install INSTALL_ROOT=$QT_DIST/bin

# Install cmake last version
RUN apt remove --purge --auto-remove cmake
RUN version=3.14 && build=3
RUN mkdir ~/temp
RUN cd ~/temp
RUN wget https://cmake.org/files/v$version/cmake-$version.$build.tar.gz
RUN tar -xzvf cmake-$version.$build.tar.gz
RUN cd cmake-$version.$build/
RUN ./bootstrap
RUN make -j4
RUN make install

# Add jenkins user
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

RUN mkdir /var/run/sshd && \
    chmod 0755 /var/run/sshd && \
    mkdir $JENKINS_AGENT_HOME/workspace && \
    chmod 777 -R $JENKINS_AGENT_HOME/workspace

EXPOSE 22

COPY clang-format /usr/local/bin

ENV PATH $QT_DIST/bin:$PATH
ENV QTDIR $QT_DIST

RUN echo "\n" >> /etc/profile
RUN echo PATH=$PATH >> /etc/profile
RUN echo "\n" >> /etc/profile
RUN echo QTDIR=$QT_DIST >> /etc/profile
RUN echo export PATH >> /etc/profile
RUN echo export QTDIR >> /etc/profile

WORKDIR $JENKINS_AGENT_HOME

CMD ["/usr/sbin/sshd", "-D"]
