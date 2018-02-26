#!/bin/bash -xe

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ${SCRIPT_DIR}/..

ODPSCMD=~/bin/odpscmd_public/bin/odpscmd


function download_table() {
    TABLE=${1}
    DATE=${2}

    ${ODPSCMD} -e "
    tunnel download ${TABLE}/dt=$DATE data/output/$DATE/${TABLE}.csv;
    "
}

for i in $(seq 1 7); do
    DATE=2014030${i}
    download_table adm_user_measures ${DATE}
    download_table adm_refer_info ${DATE}
done

download_table adm_user_measures_weekly 20140301
