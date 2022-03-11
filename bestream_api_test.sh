#!/bin/bash
TOP_DIR=${PWD}
export PATH=${PATH}:${TOP_DIR}/api_sh

unset targets
targets="${targets}$(ls -1 ${TOP_DIR}/api_sh)"

echo ${targets}
