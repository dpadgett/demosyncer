#!/bin/bash
HOST="bra.jactf.com:21"
USER=${BRA_USER}
PASS=${BRA_PASS}
FTPURL="ftp://$USER:$PASS@$HOST"
LCD="${NAS_DIR}/bra"
CD="/autorecord"
#lftp -c "set ftp:timezone CET; set ftp:passive-mode off; set ftp:port-range 65000-65100; set net:timeout 5; set net:max-retries 2; set net:reconnect-interval-base 5; open '$FTPURL'; lcd '$LCD'; cd '$CD' && mirror --verbose"
#lftp -c "set ftp:timezone UTC; set net:timeout 15; set net:max-retries 2; set net:reconnect-interval-base 5; open '$FTPURL'; lcd '$LCD'; cd '$CD' && mirror --verbose -P 8"

# more efficient to rsync on remote file host, since it can more efficiently checksum existing files
ssh -A ${NAS_USER}@${NAS_HOST} -p ${NAS_PORT} "lftp -c \"set ftp:timezone UTC; set net:timeout 15; set net:max-retries 2; set net:reconnect-interval-base 5; open '$FTPURL'; lcd '$LCD'; cd '$CD' && mirror --verbose -P 8\"" \
 | tee -a /dev/stderr | grep "^Transferring file" | sed "s/Transferring file .\(.*\).$/\1/" | grep ".dm_2[5-6]$" | sed 's|^|/cygdrive/U/demos/bra/|' >> /tmp/demos.txt
