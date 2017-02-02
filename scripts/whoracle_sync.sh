#!/bin/bash

# whoracle
#rsync -avzL --append-verify dan@whoracle.jactf.com:/home/whoracle/.local/share/openjk/base/demos/ /cygdrive/U/demos/whoracle3

# more efficient to rsync on remote file host, since it can more efficiently checksum existing files
ssh -A dan@dpadgett.org "rsync -avzL --append-verify dan@whoracle.jactf.com:/home/whoracle/.local/share/openjk/base/demos/ /cygdrive/D/demos/whoracle3" \
 | tee -a /dev/stderr | grep ".dm_2[5-6]$" | sed 's|^|/cygdrive/U/demos/whoracle3/|' >> /tmp/demos.txt
