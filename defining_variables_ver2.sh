#!/bin/bash
#  getting user input and storing it in with array
#   set -x

 declare -A config
 declare -A assigning_configs
 declare -a mysql_vars
 declare -a unassigned_mysql_vars

echo "****************************************************************"
sysuser=$(whoami)
read -p "$sysuser pls-give the name for new installing server " uid
echo "Assigning variables for mysql"
echo "****************************************************************"
# vars datadir socket  /// (( i=0; i<="${#split_var[@]}"; i++))
mysql_vars=(port server-id)
read -p "yes or no to enable binlog for this server ! " str
if [[ "$(echo "$str" | tr '[:upper:]' '[:lower:]')" == *"yes"* ]] ;then
    echo "enabled log-bin"
	mysql_vars+=(log-bin)
else
    echo "disabled log-bin !"
fi

defining_configs(){
	declare -a split_var
	split_var=($@)
	var_no="${#split_var[@]}"
	# echo "from split_var :: ${split_var[@]}"
	
	for enter in 0.."$var_no"
	do
	read -p "Enter the ${split_var[$var_name]} : " value
	config+=([${split_var[$var_name]}]="$value") 
	done
	# echo ${config[$var]};
}

let_assign_configs(){
	for key in "${!config[@]}"
	do
	if [ -n "${config[$key]}" ];then
		# echo "$key ===> ${config[$key]}"
		assigning_configs+=(["$key"]=${config[$key]})
	else
	# set -x
		echo "$key has no values"  
		unset config[$key]
		unassigned_mysql_vars+=("$key")
        # echo "${config[@]}"
	fi    
	done
}

mathing_buffer(){
	local declare -A config
	local bf_name
	memory=$(cat /proc/meminfo |grep -i "MemFree" |awk ' { print int( $2 / 1024 ) }')
	calc_buffer=$(($memory/3))
	config[innodb_buffer_pool_size]="$calc_buffer"

	if [[ "$calc_buffer" -gt 10 ]]
	then 
    	config[innodb_buffer_pool_instances]=2
	else    
    	config[innodb_buffer_pool_instances]=1
	fi

	for bf_name in ${!config[@]}
	do
		echo "$bf_name ... ${config[$bf_name]}"
		assigning_configs+=(["$bf_name"]=${config[$bf_name]})
	done

}

# mathing_buffer
# sleep 10

run_scr(){
    local var_name
	for var_name in ${!mysql_vars[@]}
	do
		defining_configs ${mysql_vars[@]}
	done
	let_assign_configs
}
    #  echo "following var need to re-assign ( ${second_run[*]} )"

 run_scr

printf "\n"
# re-assign
if [[ "${#unassigned_mysql_vars[@]}" -ge "${#mysql_vars[@]}" ]]
then 
	echo -e "need to re-assign ! \n"
	echo "inside if of and its indexes are ${!unassigned_mysql_vars[@]}"
	defining_configs "${unassigned_mysql_vars[@]}"
	let_assign_configs
elif [[ ! "${#assigning_configs[@]}" == "${#mysql_vars[@]}" ]];then
	run_scr
else
	echo -e "Variables got assigned ! \n "
fi


[[ ! -z "$uid" ]] && echo -e "uid added !!" || uid="mysql_${assigning_configs[port]}";
 echo "uid is configed as $uid";
sleep 1
assigning_configs[basedir]="/home/$sysuser/mysql_5.7"
assigning_configs[datadir]="${assigning_configs[basedir]}/${uid}_data"


# logging final cnf
cnf_name="mysql_${assigning_configs[port]}.cnf"
echo "[mysqld]" >> $cnf_name
for output in "${!assigning_configs[@]}"
do
	# log to file
	echo "$output=${assigning_configs[$output]}" >> $cnf_name
done 

# final config's
# set -x
echo "***************************************************"
echo "Printing cnf and it's values from collected-variables"
echo "***************************************************"
# echo "printing final configs ${!assigning_configs[@]}'=='${assigning_configs[@]}"
echo -e "$(cat "$cnf_name") \n"
# exit 1	
echo "********************* END ******************************"
# echo ${config[@]}





