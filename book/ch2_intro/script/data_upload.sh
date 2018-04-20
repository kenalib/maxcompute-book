#!/bin/bash -xe

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ${SCRIPT_DIR}/..

DATEFMT="yyyy-MM-dd HH:mm:ss"


function upload_data() {
    DATE=$1

    odpscmd -e "
    ALTER TABLE ods_log_tracker ADD IF NOT EXISTS PARTITION (dt=$DATE);
    "
    
    odpscmd -e "
    tunnel upload data/$DATE/output.log ods_log_tracker/dt=$DATE -fd \"\t\" -dfp '$DATEFMT';
    "
}

for i in $(seq 1 7); do
    upload_data 2014030${i}
done
