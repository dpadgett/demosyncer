#!/bin/bash

#rsync -avzL --append-verify teh@pug.jactf.com:/home/teh/demos/ /cygdrive/U/demos

# more efficient to rsync on remote file host, since it can more efficiently checksum existing files
ssh -A ${NAS_USER}@${NAS_HOST} -p ${NAS_PORT} "rsync -avzL --append-verify teh@pug.jactf.com:/home/teh/demos/ ${NAS_DIR}" \
 | tee -a /dev/stderr | grep ".dm_2[5-6]$" | sed 's|^|/cygdrive/U/demos/|' >> /tmp/demos.txt
