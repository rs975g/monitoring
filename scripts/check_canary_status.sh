#!/bin/bash

echo "checking for ASV env"
echo "==========="
#US-East ASV
result=`curl -s  -i --request GET --url https://time-series-canary.run.asv-pr.ice.predix.io/timeseries/canary/checksla  --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache' | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "checksla for ASV successful"
else
	echo "checksla for ASV failed or not able to connect - check once"
fi

result=`curl -s  -i --request GET --url https://time-series-canary.run.asv-pr.ice.predix.io/timeseries/canary/checkdelay  --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache' | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "checkdelay for ASV successful"
else
	echo "checkdelay for ASV failed or not able to connect - check once"
fi

result=`curl -s  -i --request GET --url https://time-series-canary.run.asv-pr.ice.predix.io/timeseries/canary/status  --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache' | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "status for ASV successful"
else
	echo "status for ASV failed or not able to connect - check once"
fi

result=`curl -s  -i --request GET --url https://time-series-canary.run.asv-pr.ice.predix.io/timeseries/canary/detailedstatus  --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache' | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "detailedstatus for ASV successful"
else
	echo "detailedstatus for ASV failed or not able to connect - check once"
fi

echo "==========="
echo "checking for Europe env"
echo "==========="

#Europe - CheckDelay and CheckSLA fails in Europe - possibly because of the Data Torrent pipeline throttling
#If CheckStatus fails, it is an issue

result=`curl -s  -i --request GET --url https://time-series-canary-frankfurt.run.aws-eu-central-1-pr.ice.predix.io/timeseries/canary/checksla  --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache' | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "checksla for Europe successful"
else
	echo "checksla for Europe failed or not able to connect - possibly because of the Data Torrent pipeline throttling"
fi

result=`curl -s  -i --request GET --url https://time-series-canary-frankfurt.run.aws-eu-central-1-pr.ice.predix.io/timeseries/canary/checkdelay  --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache' | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "checkdelay for Europe successful"
else
	echo "checkdelay for Europe failed or not able to connect - possibly because of the Data Torrent pipeline throttling"
fi

result=`curl -s  -i --request GET --url https://time-series-canary-frankfurt.run.aws-eu-central-1-pr.ice.predix.io/timeseries/canary/status  --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache' | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "status for Europe successful"
else
	echo "status for Europe failed or not able to connect - check once"
fi

result=`curl -s  -i --request GET --url https://time-series-canary-frankfurt.run.aws-eu-central-1-pr.ice.predix.io/timeseries/canary/detailedstatus  --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache' | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "detailedstatus for Europe successful"
else
	echo "detailedstatus for Europe failed or not able to connect - check once"
fi

echo "==========="
echo "checking for BHGE - POA"
echo "==========="

#BHGE - POA

result=`curl -s  -i --request GET --url https://time-series-canary-bhge-poa-gom.run.aws-usw02-pr.ice.predix.io/timeseries/canary/status  --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache' | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "status for BHEG - POA successful"
else
	echo "status for BHEG - POA failed or not able to connect - check once"
fi

result=`curl -s  -i --request GET --url https://time-series-canary-bhge-poa-gom.run.aws-usw02-pr.ice.predix.io/timeseries/canary/checksla  --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache' | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "checksla for BHEG - POA successful"
else
	echo "checksla for BHEG - POA failed or not able to connect - check once"
fi

result=`curl -s  -i --request GET --url https://time-series-canary-bhge-poa-gom.run.aws-usw02-pr.ice.predix.io/timeseries/canary/checkdelay  --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache' | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "checkdelay for BHEG - POA successful"
else
	echo "checkdelay for BHEG - POA failed or not able to connect - check once"
fi

result=`curl -s  -i --request GET --url https://time-series-canary-bhge-poa-gom.run.aws-usw02-pr.ice.predix.io/timeseries/canary/detailedstatus  --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache' | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "detailedstatus for BHEG - POA successful"
else
	echo "detailedstatus for BHEG - POA failed or not able to connect - check once"
fi

echo "==========="
echo "checking for Raw Power"
echo "==========="

#Raw Power
result=`curl -s  -i --request GET --url https://time-series-canary-power-prod-dd.run.aws-usw02-pr.ice.predix.io/timeseries/canary/status  --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache'  | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "status for Raw Power successful"
else
	echo "status for Raw Power failed or not able to connect - check once"
fi

result=`curl -s  -i --request GET --url https://time-series-canary-power-prod-dd.run.aws-usw02-pr.ice.predix.io/timeseries/canary/detailedstatus  --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache'  | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "detailedstatus for Raw Power successful"
else
	echo "detailedstatus for Raw Power failed or not able to connect - check once"
fi

result=`curl -s  -i --request GET --url https://time-series-canary-power-prod-dd.run.aws-usw02-pr.ice.predix.io/timeseries/canary/checkdelay --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache'  | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "checkdelay for Raw Power successful"
else
	echo "checkdelay for Raw Power failed or not able to connect - check once"
fi

result=`curl -s  -i --request GET --url https://time-series-canary-power-prod-dd.run.aws-usw02-pr.ice.predix.io/timeseries/canary/checksla --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache'  | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "checksla for Raw Power successful"
else
	echo "checksla for Raw Power failed or not able to connect - check once"
fi

echo "==========="
echo "checking for KPI-Power-Prod"
echo "==========="

#KPI-Power-Prod-Canary-EndPoints
result=`curl -s  -i --request GET --url https://time-series-canary-power-prod-kpi.run.aws-usw02-pr.ice.predix.io/timeseries/canary/status  --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache'   | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "status for KPI-Power-Prod successful"
else
	echo "status for KPI-Power-Prod failed or not able to connect - check once"
fi

result=`curl -s  -i --request GET --url https://time-series-canary-power-prod-kpi.run.aws-usw02-pr.ice.predix.io/timeseries/canary/detailedstatus  --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache'   | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "checksla for KPI-Power-Prod successful"
else
	echo "checksla for KPI-Power-Prod failed or not able to connect - check once"
fi

result=`curl -s  -i --request GET --url https://time-series-canary-power-prod-kpi.run.aws-usw02-pr.ice.predix.io/timeseries/canary/checkdelay --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache'   | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "checkdelay for KPI-Power-Prod successful"
else
	echo "checkdelay for KPI-Power-Prod failed or not able to connect - check once"
fi

result=`curl -s  -i --request GET --url https://time-series-canary-power-prod-kpi.run.aws-usw02-pr.ice.predix.io/timeseries/canary/checksla --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache'   | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "checksla for KPI-Power-Prod successful"
else
	echo "checksla for KPI-Power-Prod failed or not able to connect - check once"
fi


echo "==========="
echo "checking for PVPC"
echo "==========="

#PVPC - US West
result=`curl -s  -i --request GET --url https://time-series-canary.run.aws-usw02-pr.ice.predix.io/timeseries/canary/status --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache' --header 'postman-token: 403467ac-1663-fefd-bacf-22f5f00f851d'   | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "status for PVPC successful"
else
	echo "status for PVPC failed or not able to connect - check once"
fi


result=`curl -s  -i --request GET --url https://time-series-canary.run.aws-usw02-pr.ice.predix.io/timeseries/canary/detailedstatus --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache' --header 'postman-token: 403467ac-1663-fefd-bacf-22f5f00f851d'   | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "detailedstatus for PVPC successful"
else
	echo "detailedstatus for PVPC failed or not able to connect - check once"
fi


result=`curl -s  -i --request GET --url https://time-series-canary.run.aws-usw02-pr.ice.predix.io/timeseries/canary/checkdelay --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache' --header 'postman-token: 403467ac-1663-fefd-bacf-22f5f00f851d'   | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "checkdelay for PVPC successful"
else
	echo "checkdelay for PVPC failed or not able to connect - check once"
fi

result=`curl -s  -i --request GET --url https://time-series-canary.run.aws-usw02-pr.ice.predix.io/timeseries/canary/checksla --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache' --header 'postman-token: 403467ac-1663-fefd-bacf-22f5f00f851d'   | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "checksla for PVPC successful"
else
	echo "checksla for PVPC failed or not able to connect - check once"
fi

echo "==========="
echo "checking for OG - Old Cluster"
echo "==========="
#OG - Old Cluster
result=`curl -s  -i --request GET --url https://time-series-canary-og.run.aws-usw02-pr.ice.predix.io/timeseries/canary/status --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache' --header 'postman-token: 403467ac-1663-fefd-bacf-22f5f00f851d'   | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "status for OG - Old Cluster successful"
else
	echo "status for OG - Old Cluster failed or not able to connect - check once"
fi

result=`curl -s  -i --request GET --url https://time-series-canary-og.run.aws-usw02-pr.ice.predix.io/timeseries/canary/detailedstatus --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache' --header 'postman-token: 403467ac-1663-fefd-bacf-22f5f00f851d'   | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "detailedstatus for OG - Old Cluster successful"
else
	echo "detailedstatus for OG - Old Cluster failed or not able to connect - check once"
fi

result=`curl -s  -i --request GET --url https://time-series-canary-og.run.aws-usw02-pr.ice.predix.io/timeseries/canary/checksla --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache' --header 'postman-token: 403467ac-1663-fefd-bacf-22f5f00f851d'   | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "checksla for OG - Old Cluster successful"
else
	echo "checksla for OG - Old Cluster failed or not able to connect - check once"
fi

result=`curl -s  -i --request GET --url https://time-series-canary-og.run.aws-usw02-pr.ice.predix.io/timeseries/canary/checkdelay --header 'authorization: Basic cGhvZW5peF9tb25pdG9yOkhAYWw0OVdyU3Q=' --header 'cache-control: no-cache' --header 'postman-token: 403467ac-1663-fefd-bacf-22f5f00f851d'    | grep "HTTP/1.1"`

if [[ "$result" == *'200'* ]]; then
	echo "checkdelay for OG - Old Cluster successful"
else
	echo "checkdelay for OG - Old Cluster failed or not able to connect - check once"
fi
