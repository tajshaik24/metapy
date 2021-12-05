#!/bin/bash
sudo docker run --rm \
    -e PYBIN=$PYBIN \
    -v `pwd`:/metapy \
    quay.io/pypa/manylinux_2_24_x86_64 /metapy/scripts/build_linux_wheel.sh
