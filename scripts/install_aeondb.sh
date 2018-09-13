#!/bin/bash
ENV=$1
TSQS_PACKAGE=$2
if [ -z "${ENV}" ]
then
	echo "No environment specified."
	exit;
fi

if [ -z "${TSQS_PACKAGE}" ]
then
	echo "No package location specified."
	exit;
fi

TSQS_PACKAGE_NAME=`basename ${TSQS_PACKAGE}`
#NODES=(bp_tsqs_1 bp_tsqs_2 bp_tsqs_3 bp_tsqs_4 bp_tsqs_5 bp_tsqs_6 bp_tsqs_7 bp_tsqs_8 bp_tsqs_9 bp_tsqs_10)
NODES=`grep ${ENV}_tsqs_[0-9] ~/.ssh/config | awk '{print $2}' | sort -g`
echo ${NODES}
echo ${#NODES[@]}

for i in ${NODES[@]}; do
	echo "Copying to ${i}..."
	scp ${TSQS_PACKAGE} ${i}:/tmp
	echo "...inflating..."
	ssh ${i} "cd /opt/time_series; chmod 777 /tmp/${TSQS_PACKAGE_NAME}; sudo -u time_series cp -f /tmp/${TSQS_PACKAGE_NAME} .; sudo -u time_series unzip -o ${TSQS_PACKAGE_NAME}"
	#echo "...restarting..."
	#ssh ${i} "cd /opt/time_series/${TSQS_PACKAGE_NAME}; sudo -u time_series ./aeondb-service.sh restart"
	echo "Done"
done
