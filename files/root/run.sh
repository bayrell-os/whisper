#!/bin/bash

if [ ! -d /data/home ]; then
    mkdir -p /data/home
fi

if [ `stat -c "%U" /data/home` != "user" ] || [ `stat -c "%G" /data/home` != "user" ]; then
    chown -R user:user /data/home
fi

export PATH=/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

sudo -u user PATH=$PATH /bin/bash -c "$@"
