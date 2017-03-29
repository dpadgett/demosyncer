#!/bin/bash
HOST="vps388973.ovh.net:22"
USER=${DEMON_USER}
PASS=${DEMON_PASS}
FTPURL="sftp://$USER:$PASS@$HOST"
LCD="${NAS_DIR}/demon"
CD="/137.74.166.185:29070/base/demos/autorecord"
#lftp -c "set ftp:timezone CET; set ftp:passive-mode off; set ftp:port-range 65000-65100; set net:timeout 5; set net:max-retries 2; set net:reconnect-interval-base 5; open '$FTPURL'; lcd '$LCD'; cd '$CD' && mirror --verbose"

#lftp -c "set ftp:timezone CET; set net:timeout 15; set net:max-retries 2; set net:reconnect-interval-base 5; open '$FTPURL'; lcd '$LCD'; cd '$CD' && mirror --verbose -P 8"

# more efficient to rsync on remote file host, since it can more efficiently checksum existing files
ssh -A ${NAS_USER}@${NAS_HOST} -p ${NAS_PORT} "lftp -c \"set ftp:timezone CET; set net:timeout 15; set net:max-retries 2; set net:reconnect-interval-base 5; open '$FTPURL'; lcd '$LCD'; cd '$CD' && mirror --verbose -P 8\"" \
 | tee -a /dev/stderr | grep "^Transferring file" | sed "s/Transferring file .\(.*\).$/\1/" | grep ".dm_2[5-6]$" | sed 's|^|/cygdrive/U/demos/sith/|' >> /tmp/demos.txt
