#!/bin/bash -xe

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ${SCRIPT_DIR}/..

ODPSCMD=~/bin/odpscmd_public/bin/odpscmd
DATEFMT="yyyy-MM-dd HH:mm:ss"


function upload_data() {
    DATE=$1

    ${ODPSCMD} -e "
    ALTER TABLE ods_log_tracker ADD IF NOT EXISTS PARTITION (dt=$DATE);
    "
    
    ${ODPSCMD} -e "
    tunnel upload data/$DATE/output.log ods_log_tracker/dt=$DATE -fd \"\t\" -dfp '$DATEFMT';
    "
}

for i in $(seq 1 7); do
    upload_data 2014030${i}
done
