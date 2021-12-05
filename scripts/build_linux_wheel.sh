#!/bin/bash
set -e -u -x

function repair_wheel {
    wheel="$1"
    if ! auditwheel show "$wheel"; then
        echo "Skipping non-platform wheel $wheel"
    else
        auditwheel repair "$wheel" -w /metapy/dist
    fi
}

# Install wget and zlib-devel
apt-get update
apt-get install -y zlib1g-dev wget

# Install cmake
wget https://cmake.org/files/v3.22/cmake-3.22.0-linux-x86_64.sh
sh cmake-3.22.0-linux-x86_64.sh --prefix=/usr/local --exclude-subdir

cd /metapy
"/opt/python/${PYBIN}-${PYBIN}/bin/pip" wheel -w unfixed_wheels --verbose ./
# Bundle external shared libraries into the wheels
for whl in /metapy/unfixed_wheels/*.whl; do
    repair_wheel "$whl"
done
rm -rf /metapy/unfixed_wheels/*.whl
