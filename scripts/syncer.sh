#!/bin/bash

eval `./init.sh`

while [ 1 == 1 ]; do
  ./demo_cron.sh
  sleep $((60 * 15))
done
