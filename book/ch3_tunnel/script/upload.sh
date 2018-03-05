#!/bin/bash -xe

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ${SCRIPT_DIR}/..

if [ $# -ne 2 ]; then
  echo "Usage sample: $0 20140212 ods_log_tracker/dt=20140212" 1>&2
  exit 1
fi

DATE=$1
# with partition, such as ods_log_tracker/dt=201302
# if needed, ALTER TABLE ods_log_tracker ADD IF NOT EXISTS PARTITION (dt=20140212);
TABLE=$2


# this should be if on server or on local Mac
if [[ ${EUID:-${UID}} -eq 0 ]]; then
    ODPSCMD=/home/admin/bin/odpscmd_public/bin/odpscmd;
    LOG_DIR=/var/log/nginx
else
    ODPSCMD=~/bin/odpscmd_public/bin/odpscmd;
    LOG_DIR=input
    cp resources/access.log.${DATE}.gz ${LOG_DIR}
fi

DATEFMT="yyyy-MM-dd HH:mm:ss"

# gzip filename format: access.log.20140212.gz
LOG_GZ=${LOG_DIR}/access.log.${DATE}.gz

IN_FILE=${LOG_DIR}/access.log.${DATE}
OUT_DIR=output/${DATE}
mkdir -p ${OUT_DIR}


function unzip_file() {
    if [ ! -f "$LOG_GZ" ]; then
        echo "file not exist: $LOG_GZ"
        return 1
    fi

    gunzip -kf ${LOG_GZ}
    python script/parse.py ${IN_FILE} ${IN_FILE}.clean ${IN_FILE}.dirty
    return $?
}

function upload() {
    ${ODPSCMD} -e "
    tunnel upload ${IN_FILE}.clean ${TABLE} -fd \"\t\" -dfp '$DATEFMT';
    " >> ${OUT_DIR}/log.txt 2>&1

    if [ $? == 0 ]; then
        echo 0 > ${OUT_DIR}/result.txt
        return 0
    else
        echo 1 > ${OUT_DIR}/result.txt
        return 1
    fi
}

unzip_file && upload
exit $?
