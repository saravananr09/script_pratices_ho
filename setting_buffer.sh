#!/bin/bash 
# set -x
# ram=$(free -m |awk '{print $7}'|grep -v "available" |head -1);
declare -A config
memory=$(cat /proc/meminfo |grep -i "MemFree" |awk ' { print int($2 / 1024 ) }')
echo "Available ram is $memory MB"

calc_buffer=$(cat /proc/meminfo |grep -i "MemFree" |awk ' { mem = $2 / 1024; in_mb = int(mem / 3 + 1); print in_mb; }')


echo "U can set the buffer by  $calc_buffer MB" ;
config[buffer_pool]="$calced_buffer"
if [[ "$calc_buffer" -gt 1000 ]]
then 
    echo "able to run mysql with 2 buffer instances";
    config[buffer_pool_instances]=2
else    
    echo "able to run mysql with 1 buffer instance";
    config[buffer_pool_instances]=1
fi
set -x
echo "${config[@]}"
sleep 1
for cons in ${!config[@]}
do  
    echo "${config[$cons]}"
done

# printf ("Ram : %s ","$ram");



