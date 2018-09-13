#!/bin/bash
ENV=$1
TSQS_PACKAGE=$2
if [ -z "${ENV}" ]
then
	echo "No environment specified."
	exit;
fi

if [ -z "${TSQS_PACKAGE_NAME}" ]
then
	echo "No package name."
	exit;
fi

if [ -z "${TSQS_PROPS_NAME}" ]
then
	echo "No Props package name."
	exit;
fi

#NODES=(bp_tsqs_1 bp_tsqs_2 bp_tsqs_3 bp_tsqs_4 bp_tsqs_5 bp_tsqs_6 bp_tsqs_7 bp_tsqs_8 bp_tsqs_9 bp_tsqs_10)
NODES=`grep ${ENV}_tsqs_[0-9] ~/.ssh/config | awk '{print $2}' | sort -g`
echo ${NODES}
echo ${#NODES[@]}

for i in ${NODES[@]}; do
	echo "Restarting ${i}..."
	ssh ${i} "export ENV_PROPERTY_FILE=/opt/time_series/${TSQS_PROPS_PACKAGE}/conf/og-bp.properties; /opt/time_series/${TSQS_PACKAGE_NAME}/bin/aeondb-servicee.sh restart"
	echo "Done"
done

# sudo -u time_series "export ENV_PROPERTY_FILE=/opt/time_series/aeondb-env-2.0.1-SNAPSHOT-b3/conf/og-bp.properties; /opt/time_series/aeondb-service-2.0.4-SNAPSHOT-b104/bin/aeondb stop; /opt/time_series/aeondb-service-2.0.4-SNAPSHOT-b104/bin/aeondb start"

# sudo -u time_series ENV_PROPERTY_FILE=/opt/time_series/aeondb-env-2.0.1-SNAPSHOT-b3/conf/og-bp.properties /opt/time_series/aeondb-service-2.0.4-SNAPSHOT-b104/bin/aeondb stop
# sudo -u time_series ENV_PROPERTY_FILE=/opt/time_series/aeondb-env-2.0.1-SNAPSHOT-b3/conf/og-bp.properties /opt/time_series/aeondb-service-2.0.4-SNAPSHOT-b104/bin/aeondb start

