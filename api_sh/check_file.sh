#!/bin/bash -e
do_check_file() 
{
    echo "file is $1"
    if [ -f "$1" ];then
        rm -f $1
    else
        touch $1
    fi
}


do_check_outdir() 
{
    if [[ -d ${OUTPUT} ]]
    then
        echo "${OUTPUT} exists on your filesystem."
    else
        echo "${OUTPUT} is not exists on your filesystem."
        mkdir -p ${OUTPUT}
    fi
}