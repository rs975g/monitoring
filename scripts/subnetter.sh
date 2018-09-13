#!/bin/bash

subnet=$1
RANGE=$2
if [ $# == 0 ];
then
echo "Usage: ./subnetter.sh  IP/SUBNET"
exit
fi

   if [ i -lt $RANGE ]
  then
    network=`echo $subnet | cut -d / -f1`
    broadcast=`/usr/local/bin/sipcalc $1 | grep -i "Broadcast address" | awk '{print $4}'`
    gateway=`/usr/local/bin/sipcalc $1 | grep -i "Usable range" | awk '{print $4}'`
    hosts=`/usr/local/bin/sipcalc $1 |  grep -i "Addresses in network" | cut -d '-' -f2`

    echo "subnet=" $subnet "network=" $network "broadcast=" $broadcast "gateway=" $gateway "hosts=" $hosts

    i=$((i+1))
fi
