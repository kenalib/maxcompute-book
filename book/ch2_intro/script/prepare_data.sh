#!/bin/bash -xe

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd ${SCRIPT_DIR}/..


function generate_logs() {
    IDX=$1
    DIV=$2
    DATE=2014030${IDX}

    awk "NR%${DIV}==1" data/coolshell_20140212.log \
        > data/coolshell_${DATE}.log
    sed -e "s#12/Feb/2014#0${IDX}/Mar/2014#g;" data/coolshell_${DATE}.log \
        > data/coolshell_${DATE}.log.tmp
    mv data/coolshell_${DATE}.log.tmp data/coolshell_${DATE}.log
}

primes=(
    1217
    2011
    601
    971
    1777
    797
    1009
)

for i in $(seq 1 7); do
    generate_logs ${i} ${primes[i-1]}
done
