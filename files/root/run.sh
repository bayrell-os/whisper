#!/bin/bash

# Run scripts
if [ -d /root/run.d ]; then
  for i in /root/run.d/*.sh; do
    if [ -f $i ]; then
      . $i
    fi
  done
  unset i
fi

export PATH=/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
sudo -u user PATH=$PATH /bin/bash -c "$@"
