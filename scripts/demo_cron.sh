#!/bin/bash
#/home/syncer/whoracle_sync.sh
date | tee demo_first.log

rm /tmp/demos.txt

timeout 10m bash -c "/home/syncer/whoracle_sync.sh && echo whoracle_sync done" | tee -a demo_first.log || echo "whoracle_sync timed out" | tee -a demo_first.log
timeout 10m bash -c "/home/syncer/refresh_sync.sh && echo refresh_sync done" | tee -a demo_first.log || echo "refresh_sync timed out" | tee -a demo_first.log
timeout 10m bash -c "/home/syncer/sylar_sync.sh && echo sylar_sync done" | tee -a demo_first.log || echo "sylar_sync timed out" | tee -a demo_first.log
timeout 10m bash -c "/home/syncer/sith_sync.sh && echo sith_sync done" | tee -a demo_first.log || echo "sith_sync timed out" | tee -a demo_first.log
timeout 10m bash -c "/home/syncer/bra_sync.sh && echo bra_sync done" | tee -a demo_first.log || echo "bra_sync timed out" | tee -a demo_first.log
timeout 10m bash -c "/home/syncer/demon_sync.sh && echo demon_sync done" | tee -a demo_first.log || echo "demon_sync timed out" | tee -a demo_first.log
if [ -s /tmp/demos.txt ]; then
  timeout 30m bash -c "curl http://pyservices:3031/exec.py?file=create_demo_metadata.py --data-binary @/tmp/demos.txt && echo create_demo_metadata done" | tee -a demo_first.log || echo "create_demo_metadata timed out" | tee -a demo_first.log
  timeout 10m bash -c "curl http://pyservices:3031/exec.py?file=create_users.py && echo create_users done" | tee -a demo_first.log || echo "create_users timed out" | tee -a demo_first.log
  timeout 10m bash -c "curl http://pyservices:3031/exec.py?file=calculate_ranks_v3.py && echo calculate_ranks_v3 done" | tee -a demo_first.log || echo "calculate_ranks_v3 timed out" | tee -a demo_first.log
  timeout 20m bash -c "/home/syncer/demo_post_trigger.sh </tmp/demos.txt && echo demo_post_trigger done"
fi
echo "all done" | tee -a demo_first.log
