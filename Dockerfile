FROM ubuntu:20.10
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y upgrade
RUN apt-get -y update
RUN apt-get -y install apt-utils 
RUN apt-get -y install build-essential g++ clang
RUN apt-get -y install zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev 
RUN apt-get -y install libreadline-dev libffi-dev wget
RUN apt-get -y install vim cmake valgrind
RUN apt-get -y install ccache 
RUN apt-get -y install python3.8 python3-pip
RUN pip3 install cmake_format
RUN apt-get -y install cppcheck
RUN pip3 install conan
RUN apt-get -y install doxygen graphviz

COPY . /app
# continue anyway even if we could not make directory
# as it already exists
RUN rm -rf /app/build || true
RUN mkdir /app/build || true
WORKDIR /app/build
RUN cmake ..
RUN make
RUN make test


