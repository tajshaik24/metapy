#!/bin/bash
pip3 wheel -w dist --verbose ./
ls dist/*.whl
pip3 install dist/*.whl
