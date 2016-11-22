# intel's sdk doesn't compile with 16.04!
FROM ubuntu:14.04

# update apt and get requirements of build
RUN apt-get update && apt-get -y install git wget python screen build-essential ocaml automake autoconf libtool libcurl4-openssl-dev protobuf-compiler protobuf-c-compiler libprotobuf-dev libprotobuf-c0-dev

# load & build a tested version of the linux sgx sdk
RUN git clone https://github.com/01org/linux-sgx.git && cd linux-sgx && git reset --hard 85947ca && ./download_prebuilt.sh && make && make sdk_install_pkg && make psw_install_pkg

# copy the patch necessary for in container installation
COPY psw-installer.patch /linux-sgx

# and apply it
RUN patch /linux-sgx/linux/installer/bin/sgx_linux_x64_psw_1.6.100.34922.bin < /linux-sgx/psw-installer.patch

# before installing the sdk and the platform services
RUN echo yes | /linux-sgx/linux/installer/bin/sgx_linux_x64_sdk_1.6.100.34922.bin 
RUN /linux-sgx/linux/installer/bin/sgx_linux_x64_psw_1.6.100.34922.bin

RUN rm -r /linux-sgx

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bash"]
