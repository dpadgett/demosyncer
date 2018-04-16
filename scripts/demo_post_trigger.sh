#!/bin/bash

ssh -A ${NAS_USER}@${NAS_HOST} -p ${NAS_PORT} "./demo_post_trigger.sh"
