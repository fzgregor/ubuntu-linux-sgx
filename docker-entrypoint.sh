#!/bin/bash

source /sgxsdk/environment
/opt/intel/sgxpsw/aesm/aesm_service &

exec "$@"
