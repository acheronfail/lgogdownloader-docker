FROM ubuntu

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential libcurl4-openssl-dev libboost-regex-dev \
  libjsoncpp-dev librhash-dev libtinyxml2-dev libhtmlcxx-dev \
  libboost-system-dev libboost-filesystem-dev libboost-program-options-dev \
  libboost-date-time-dev libboost-iostreams-dev libssl-dev help2man cmake \
  pkg-config zlib1g-dev qtwebengine5-dev ninja-build wget

WORKDIR /opt
COPY ./entrypoint.sh ./entrypoint.sh
RUN wget https://github.com/Sude-/lgogdownloader/releases/download/v3.8/lgogdownloader-3.8.tar.gz
RUN tar -xvzf ./lgogdownloader-3.8.tar.gz

RUN cd lgogdownloader-3.8 && cmake -B build \
  -DCMAKE_INSTALL_PREFIX=/usr \
  -DCMAKE_BUILD_TYPE=Release \
  -DUSE_QT_GUI=ON -GNinja \
  && ninja -Cbuild install

WORKDIR /data
CMD ["lgogdownloader"]
ENTRYPOINT ["/opt/entrypoint.sh"]
