#!/bin/bash -xe

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ${SCRIPT_DIR}/..

REMOTE_SCRIPT=/home/admin/script     # path on remote hosts

# on Mac, use gdate instead of date after brew install coreutils
# DATE=`gdate -d yesterday "+%Y%m%d"`
DATE=20140212
TABLE=ods_log_tracker

LOG=log/${DATE}
mkdir -p ${LOG}

OUT_REMOTE=/home/admin/output/${DATE}
OUT_DIR=output/${DATE}
mkdir -p ${OUT_DIR}


# 1) create table/partition
function prepare() {
    odpscmd -e "ALTER TABLE $TABLE DROP IF EXISTS PARTITION (dt='$DATE');"
    odpscmd -e "ALTER TABLE $TABLE ADD PARTITION (dt='$DATE');"
    return $?
}

function upload() {
    pssh -A -h host.txt -i "bash -l $REMOTE_SCRIPT/upload.sh $DATE $TABLE/dt='$DATE'"
    return $?
}

function check() {
    t1=`date +%s`
    limit=43200

    while true; do
        t2=`date +%s`
        if [ $((t2-t1)) -gt ${limit} ]; then
            echo "time out"
            return 1;
        fi

        pslurp -A -l root -h host.txt -L ${OUT_DIR} ${OUT_REMOTE}/result.txt result.txt >> ${LOG}/master.log 2>&1

        if [ $? -ne 0 ]; then
            sleep 60;
        else
            ret=0
            for server in `/bin/ls ${OUT_DIR}`; do
                grep 0 ${OUT_DIR}/${server}/result.txt >& /dev/null
                if [ $? -ne 0 ]; then
                    echo "$server failed."
                    ret=1
                fi
            done
            return ${ret};
        fi
    done
}

function delete() {
    echo delete older data files and tmp files
}

prepare
upload
check
delete
