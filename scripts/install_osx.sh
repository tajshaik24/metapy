#!/bin/bash
brew update
brew outdated cmake || brew upgrade cmake
pip3 install wheel
brew unlink llvm