#!/bin/bash

ENVIRON=$1
scp get_offsets.sh ${ENVIRON}_zookeeper_1:/tmp/; ssh ${ENVIRON}_zookeeper_1 "chmod u+x /tmp/get_offsets.sh; /tmp/get_offsets.sh ${ENVIRON}"
