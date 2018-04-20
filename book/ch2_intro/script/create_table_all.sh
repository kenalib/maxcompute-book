#!/bin/bash -xe

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ${SCRIPT_DIR}/..


function create_table() {
    SQL=$1

    odpscmd -f ${SQL}
}

for i in $(seq 1 8); do
    create_table sql/create/create0${i}*
done
