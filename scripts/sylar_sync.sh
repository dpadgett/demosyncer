#!/bin/bash
HOST="sylar.jactf.com:21"
USER=${SYLAR_USER}
PASS=${SYLAR_PASS}
FTPURL="ftp://$USER:$PASS@$HOST"
LCD="/cygdrive/D/demos/sylar"
CD="/"
#lftp -c "set ftp:timezone CET; set ftp:passive-mode off; set ftp:port-range 65000-65100; set net:timeout 5; set net:max-retries 2; set net:reconnect-interval-base 5; open '$FTPURL'; lcd $LCD; cd $CD && mirror --verbose -P 8"

# more efficient to rsync on remote file host, since it can more efficiently checksum existing files
ssh -A dan@dpadgett.org "lftp -c \"set ftp:timezone CET; set ftp:passive-mode off; set ftp:port-range 65000-65100; set net:timeout 5; set net:max-retries 2; set net:reconnect-interval-base 5; open '$FTPURL'; lcd $LCD; cd $CD && mirror --verbose -P 8\"" \
 | tee -a /dev/stderr | grep "^Transferring file" | sed "s/Transferring file .\(.*\).$/\1/" | grep ".dm_2[5-6]$" | sed 's|^|/cygdrive/U/demos/sylar/|' >> /tmp/demos.txt
