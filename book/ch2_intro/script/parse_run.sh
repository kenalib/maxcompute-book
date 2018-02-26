#!/bin/bash -xe

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ${SCRIPT_DIR}/..


function parse() {
    DATE=$1
    mkdir -p data/${DATE}
    python script/parse.py \
        data/coolshell_${DATE}.log \
        data/${DATE}/output.log \
        data/${DATE}/dirty.log
}

for i in $(seq 1 7); do
    parse 2014030${i}
done
