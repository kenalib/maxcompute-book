#!/bin/bash -xe

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ${SCRIPT_DIR}/..

ODPSCMD=~/bin/odpscmd_public/bin/odpscmd


function odpscmd_bizdate() {
    DATE=${1}
    SQL=${2}

    sed -e "s#\${bizdate}#$DATE#g;" ${SQL} | ${ODPSCMD}
}

for i in $(seq 1 7); do
    DATE=2014030${i}
    for j in $(seq 2 7); do
        SQL=sql/load/load0${j}_*.osql
        # odpscmd_bizdate ${DATE} ${SQL}
    done
done


DATE1=20140301
DATE2=20140307
SQL=sql/load/load08_adm_user_measures_weekly.osql

sed -e "s#\${bizdate1}#$DATE1#g;s#\${bizdate2}#$DATE2#g;" ${SQL} | ${ODPSCMD}
