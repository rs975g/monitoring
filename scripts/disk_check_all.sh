#!/bin/bash

usage="$(basename "$0") [-h] [-e env_name] [...] -- check disk usage and free space for timeseries servers

where:
    -h  show help
    -e  environment name like pvpc, bp, power_prod, frankfurt, us-east, japan, bhge-poa (default: all)
    -t  threshold_used_pct - greater than this much threshold as used percentage
    (not yet available) -T  threshold_free_pct - greater than this much threshold as free percentage
    (not yet available) -f  threshold_used_pct - greater than this much threshold as used bytes
    (not yet available) -F  threshold_free_pct - greater than this much threshold as free bytes

sample usage: sh script_name.sh -e pvpc -t 70
"

environment=all
while getopts ':he:t:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    e) environment=$OPTARG
       ;;
    t) threshold_used=$OPTARG
       ;;
    T) threshold_free=$OPTARG
       ;;
    f) min_used_space=$OPTARG
       ;;
    F) max_used_space=$OPTARG
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done

shift $((OPTIND - 1))

today=$(date +"%m-%d-%Y")

disk_check()
{
  #while read line
for line in `cat iplist_$today.out`
do
  today=$(date +"%m-%d-%Y")
  echo $line > iplist_inloop_$today.out
  ssh -q -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null  502616003@$line 'df -h' > diskspace
  if [[ $? -gt 0 ]];then
    echo "not able to connect the host : $line"
  else
  ## check root partition
    if [[ `grep xvda diskspace |wc -l` -gt 0 ]]; then
      grep xvda diskspace > diskspace_root
      paste iplist_inloop_$today.out diskspace_root >> diskspace.out 
      rm diskspace_root 
    fi
    ## check kafka-data
    if [[ `grep xvdh diskspace |wc -l` -gt 0 ]]; then
      grep xvdh diskspace > diskspace_kafka_data
      paste iplist_inloop_$today.out diskspace_kafka_data >> diskspace.out 
      rm diskspace_kafka_data 
    fi
    ## check kafka-logs
    if [[ `grep xvdg diskspace |wc -l` -gt 0 ]]; then
      grep xvdg diskspace > diskspace_kafka_logs
      paste iplist_inloop_$today.out diskspace_kafka_logs >> diskspace.out 
      rm diskspace_kafka_logs 
    fi
    ## check hadoop
    if [[ `grep xvdf diskspace |wc -l` -gt 0 ]]; then
      grep xvdf diskspace > diskspace_hadoop
      paste iplist_inloop_$today.out diskspace_hadoop >> diskspace.out 
      rm diskspace_hadoop 
    fi
     if [[ `grep nvme0n1 diskspace |wc -l` -gt 0 ]]; then
      grep nvme0n1 diskspace > diskspace_data01
      paste iplist_inloop_$today.out diskspace_data01 >> diskspace.out 
      rm diskspace_data01 
    fi
    if [[ `grep nvme1n1 diskspace |wc -l` -gt 0 ]]; then
      grep nvme1n1 diskspace > diskspace_data02
      paste iplist_inloop_$today.out diskspace_data02 >> diskspace.out 
      rm diskspace_data02
    fi
  fi
    ## clean up files
  cat diskspace.out | column -t >> diskcheck_$today
  rm diskspace.out
done
rm iplist_$today.out
rm iplist_inloop_$today.out
  #exit 1
}

get_frankfurt_info()

{

  #Get ips list 
  awk '/### START of EAST ###/,/### END of EAST ###/' ~/.ssh/config|grep -i "Hostname"|awk -F' ' '{print $2}' > iplist_$today.out 

# Run disk_check funcion to get files
disk_check

}

get_pvpc_info()

{
  #Get ips list 
 awk '/### START of PVPC ###/,/### END of PVPC ###/' ~/.ssh/config|grep -i "Hostname"|awk -F' ' '{print $2}' > iplist_$today.out 

 # Run disk_check funcion to get files
 disk_check

}

get_BP_info()

{
  #Get ips list 
  awk '/### START of BP ###/,/### END of BP ###/' ~/.ssh/config|grep -i "Hostname"|awk -F' ' '{print $2}' > iplist_$today.out

  # Run disk_check funcion to get files
  disk_check

}

get_power_prod_info()

{
  #Get ips list 
  awk '/### START of Power Prod ###/,/### END of Power Prod ###/' ~/.ssh/config|grep -i "Hostname"|awk -F' ' '{print $2}'  > iplist_$today.out

  # Run disk_check funcion to get files
  disk_check

}

get_us_east_info()

{
  #Get ips list 
   awk '/### START of EAST ###/,/### END of EAST ###/' ~/.ssh/config|grep -i "Hostname"|awk -F' ' '{print $2}' > iplist_$today.out

  # Run disk_check funcion to get files
  disk_check

}

get_japan_info()

{
  #Get ips list 
  awk '/### START of japan ###/,/### END of japan ###/' ~/.ssh/config|grep -i "Hostname"|awk -F' ' '{print $2}' > iplist_$today.out

  # Run disk_check funcion to get files
  disk_check

}

get_bhge_poa_info()

{
  #Get ips list 
  awk '/### START of BHGE-POA ###/,/### END of BHGE-POA ###/' ~/.ssh/config|grep -i "Hostname"|awk -F' ' '{print $2}' > iplist_$today.out

  # Run disk_check funcion to get files
  disk_check

}

get_azure_info()

{
  #Get ips list 
  awk '/### START of Azure ###/,/### END of Azure ###/' ~/.ssh/config|grep -i "Hostname"|awk -F' ' '{print $2}' > iplist_$today.out

  # Run disk_check funcion to get files
  disk_check

}

get_power_dev_info()

{ 
  #Get ips list 
  awk '/### START of Power DEV ###/,/### END of Power DEV ###/' ~/.ssh/config|grep -i "Hostname"|awk -F' ' '{print $2}' > iplist_$today.out

  # Run disk_check funcion to get files
  disk_check

}

# Connect to all VPNs before executing 

#for i in `osascript -e 'tell application "Tunnelblick"
#    get name of configurations
#  end tell'`
#do
#  VPN=`echo $i|cut -d',' -f1`
#  echo $VPN
#  osascript <<EOF
#  tell application "Tunnelblick"
#    connect "$VPN"
#    get state of first configuration where name="$VPN"
#    repeat until result = "CONNECTED"
#      delay 1
#      get state of first configuration where name="$VPN"
#    end repeat
#  end tell
#EOF
#done

if [[ $environment == "Frankfurt" || $environment == 'frankfurt' ]]; then

#echo "yes, this is frankfurt"
get_frankfurt_info

fi

if [[ $environment == "PVPC" || $environment == "pvpc" ]]; then

get_pvpc_info
 
fi

if [[ $environment == "OG" || $environment == "og" || $environment == "bp" || $environment == "BP" ]]; then

 get_BP_info

fi

if [[ $environment == "Power_Prod" || $environment == "POWER_PROD" || $environment == "power_prod" ]]; then

 get_power_prod_info

fi

if [[ $environment == "US-east" || $environment == "us-east" || $environment == "EAST" || $environment == "east" || $environment == "asv" || $environment == "ASV" ]]; then

 get_us_east_info

fi

if [[ $environment == "JAPAN" || $environment == "japan" ]]; then

 get_japan_info

fi

if [[ $environment == "BHGE_POA" || $environment == "bhge_poa" ]]; then

 get_bhge_poa_info

fi

if [[ $environment == "Azure" || $environment == "azure" ]]; then

 get_azure_info

fi


if [[ $environment == "Power_Dev" || $environment == "Power_DEV" ]]; then

 get_power_dev_info

fi

#### if env = all

if [[ $environment == "all" ]]; then
  get_frankfurt_info
  get_pvpc_info
  get_BP_info
  get_power_prod_info
  get_us_east_info
  get_us_east_info
  get_japan_info
  get_bhge_poa_info
  get_azure_info
  get_power_dev_info
fi

###### do some maths for each env ########

echo $threshold_used

#if [[ -z threshold_used ]]; then
while read line
do
num=`echo $line|awk -F' |%' '{print $6}'`
if [ $num -ge "$threshold_used" ]; then
echo $line >> pct_used_diskcheck_$today
fi
done < diskcheck_$today
#fi
