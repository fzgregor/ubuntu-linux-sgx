Ubuntu with Intel SGX SDK
=========================

This image provides a ubuntu system with precompile Intel SGX SDK.

The SDK's source is found under `/linux-sgx`.

The executable `/opt/intel/sgxpsw/aesm/aesm_service` starts Intel's Architecture Enclaves Service (AES).
It contains the signing, launch, provisioning and quoting enclave and is necessary to use essential Intel SGX functionality.
For the AES to work properly the Intel SGX device file "/dev/isgx" has to be provided inside of the container.
This can be achieved by starting the image with the `--device=/dev/isgx` option, e.g.:

    docker run -it --rm --device=/dev/isgx ubuntu-intel-sgx:latest bash