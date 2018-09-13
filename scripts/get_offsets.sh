#!/bin/bash

#PVPC: /pipeline/release-vpc/timeseries/com.datatorrent.contrib.kafka.defaultcluster/ts-release/
#Japan:  /pipeline/release-japan/timeseries/com.datatorrent.contrib.kafka.defaultcluster/ts-release/
#ASV

ENVIRON=$1
broker_ip_port=""
zk_path=""
topicname=""

if [ -z "$ENVIRON" ]
then
	echo "No environment specified."
fi

if [[ ($ENVIRON == "asv") ]]
then
	broker_ip_port="10.128.7.157:6667"
	zk_path="/pipeline/release-vpc/timeseries/com.datatorrent.contrib.kafka.defaultcluster"
	topicname="ts-release"
fi

if [[ ($ENVIRON == "pvpc") ]]
then
	broker_ip_port="10.72.8.113:6667"
	zk_path="/pipeline/release-vpc/timeseries/com.datatorrent.contrib.kafka.defaultcluster"
	topicname="ts-release-v1"
fi

if [[ ($ENVIRON == "bp") ]]
then
	broker_ip_port="10.72.40.103:6667"
	zk_path="/pipeline/release-vpc/timeseries/com.datatorrent.contrib.kafka.defaultcluster"
	topicname="ts-release"
fi

if [[ ($ENVIRON == "japan") ]]
then
	broker_ip_port="10.120.11.112:6667"
	zk_path="/pipeline/release-japan/timeseries/com.datatorrent.contrib.kafka.defaultcluster"
	topicname="ts-release"
fi

if [[ $broker_ip_port == "" ]]
then
	echo "Invalid Env Specified."
        echo "Usage: run this on a zookeeper node"
        echo "       get_offset.sh <pvpc|asv|bp|japan>"
	exit
fi


pattern="^[ 0-9,]+$"
partitions=`/usr/hdp/current/zookeeper-client/bin/zkCli.sh -server localhost:2181 ls ${zk_path}/${topicname} | tail -1 |& awk -F\[ '{print $2}' |& awk -F\] '{print $1}'`
if [[ ${partitions} =~ $pattern ]]
then
	IFS=',' read -ra PARTITIONS <<< "$partitions"
        for i in ${PARTITIONS[@]}
        do
        	# echo ${name}/${i}
                new_path=${zk_path}/${topicname}/${i}
                echo ""
                echo ""
                echo $new_path
                echo "Current Offset"
                echo -n "  "
                /usr/hdp/current/zookeeper-client/bin/zkCli.sh -server localhost:2181 get ${new_path} |& grep -E "^[0-9][0-9]*$|^mtime" |& sed 'N;s/\n/; /'
                echo "Latest Offset"
                echo -n "  "
                offset=`/usr/hdp/current/kafka-broker/bin/kafka-run-class.sh kafka.tools.GetOffsetShell --topic ${topicname} --broker-list ${broker_ip_port} --time -1 |& grep ":${i}:" |& awk -F\: '{print $3}'`
                offsetdatems=`/usr/hdp/current/kafka-broker/bin/kafka-run-class.sh kafka.tools.SimpleConsumerShell --topic ${topicname} --broker-list ${broker_ip_port} --offset ${offset} --partition ${i} --print-offsets --max-messages 1 | grep -Po '[0-9][0-9]*}$' | awk -F\} '{print $1}'`
                offsetdate=`date -d @${offsetdatems%???}`
                echo ${offset}"; "${offsetdate}
                echo "Earliest Offset"
                echo -n "  "
                offset=`/usr/hdp/current/kafka-broker/bin/kafka-run-class.sh kafka.tools.GetOffsetShell --topic ${topicname} --broker-list ${broker_ip_port} --time -2 |& grep ":${i}:" |& awk -F\: '{print $3}'`
                offsetdatems=`/usr/hdp/current/kafka-broker/bin/kafka-run-class.sh kafka.tools.SimpleConsumerShell --topic ${topicname} --broker-list ${broker_ip_port} --offset ${offset} --partition ${i} --print-offsets --max-messages 1 | grep -Po '[0-9][0-9]*}$' | awk -F\} '{print $1}'`
                offsetdate=`date -d @${offsetdatems%???}`
                echo ${offset}"; "${offsetdate}
        done
else
	echo "Invalid Partitions found: " ${partitions}
fi

echo ""
echo ""
echo "Use these to find date for an offset (for the first partition):"
echo "Pick an approximate offset based on the time last canary succeeded"
echo ""
echo ""
echo "offset="
echo "offsetdatems=\`/usr/hdp/current/kafka-broker/bin/kafka-run-class.sh kafka.tools.SimpleConsumerShell --topic ${topicname} --broker-list ${broker_ip_port} --offset \${offset} --partition 0 --print-offsets --max-messages 1 | grep -Po '[0-9][0-9]*}$' | awk -F\} '{print \$1}'\`"
echo date -d @\${offsetdatems%???}

