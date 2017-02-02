#!/bin/bash

#rsync -avzL --append-verify teh@pug.jactf.com:/home/teh/demos/ /cygdrive/U/demos

# more efficient to rsync on remote file host, since it can more efficiently checksum existing files
ssh -A dan@dpadgett.org "rsync -avzL --append-verify teh@pug.jactf.com:/home/teh/demos/ /cygdrive/D/demos" \
 | tee -a /dev/stderr | grep ".dm_2[5-6]$" | sed 's|^|/cygdrive/U/demos/|' >> /tmp/demos.txt
