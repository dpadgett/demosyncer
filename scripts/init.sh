#!/bin/bash

# needed since permissions will be wrong on mounted-in ssh keys

cp -R syncerssh .ssh
chmod 600 .ssh/id_rsa
agent=$(ssh-agent -s)
eval $agent >/dev/null
ssh-add >/dev/null
echo $agent

# also inject server credentials which cannot be stored in git / public docker image
cat server_creds.sh
