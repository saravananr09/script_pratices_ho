#! /bin/bash
# set -x
###################################################################################
MYSQL="/mnt/e/back/vicky/mysql_base/bin"
USER="root"
SOCKET="/tmp/mysql78.sock"
#below var is for my refs
mysql_connection="$MYSQL/mysql -u $USER -S $SOCKET"
backup_path="/mnt/e/linux_script_pratices/bkup_from_script"
###################################################################################
# using static arr for my ref ('mysql' 'information_schema' 'performance_schema')

#function to fetch data about the tables
get_tables_dump(){
	PS3="type any index of the above table "
	local info_tables=($($MYSQL/mysql -uroot -S $SOCKET -sN -e "show tables from $DB"))
			select table in ${info_tables[*]}
			do
				case $table in				
					$table)
						echo "You have selected the $table table";
						# set -x
						echo "#####################################################################"
						echo "starting dump for $table table..."
						# mysqsleep 2 
						# echo "dump_$date"| awk ' { print $1 "_" $NF } '
						# set -x
						date=$($mysql_connection -sN -e 'select now();'| awk ' { print $1 "_" $NF } ')
						$($MYSQL/mysqldump -u $USER -S $SOCKET $DB $table > ./bkup_from_script/"dump_$table"_$date.sql ) &
						# set -x	
						# dump_file=$backup_path_dump_$table'_'$date.sql
						dump_file=$backup_path/"dump_$table"_$date.sql

						#echo "$backup_path/$dump_file";
						# $(rm -rf $dump_file)
						if [ -e `$dump_file` ]; then
								echo $dump_file;
								echo "dump completed !"
								echo "#####################################################################"
					
    							echo "$dump_file exists."
								get_databases
						else
							echo 'dump failed for '$table;
							echo "#####################################################################"
							#exit
							get_tables_dump $DB
						fi
						break;;

					*)
						echo "Invalid option $table"	
						exit ;;
				esac
			done
}

# set -x  $backup_path"dump_$table"_$date.sql
# get_tablesa(){
# local a=($($MYSQL/mysql -uroot -S $SOCKET -sN -e "show tables from $DB"))
# echo $a;
# }
# set +x

#getting DB's
get_databases() {
	local mysql_db=$($mysql_connection -sN -e "show databases;" )
	PS3="Please select the Database: "
	select DB in ${mysql_db[*]}
do
	case $DB in
		$DB)
			echo -e "You have selected the $DB database ! \n"
			#info_tables=($($MYSQL/mysql -uroot -S $SOCKET -e "show tables from $DB")) 
			echo -e "Tables ==> \n"
			get_tables_dump $DB
			break 2;;&	
        *) 
			echo "invalid option $DB";;
	esac			
done
}


#calling main function
get_databases












#####################
#code dumps

#dbs=" mysql information_schema performance_schema"

	# ${mysql_db[0]})
	    # 		echo -e "You have selected the $DB database !\n";
		# 	$($MYSQL/mysql -u $USER -S $SOCKET -e "show tables from ${mysql_db[0]}" > mysql_tables.txt); 
		# 	for table in $(< mysql_tables.txt)
		# 	do
		# 		echo $table;
		#   	done
		# 	$(rm -rf mysql_tables.txt)
		# 	;;
	# i=0;
	# while [ $i -lt 1 ] 
	# do

			# (( i++ ))
	# done


	# $DB)
		# 	echo "You have selected the $DB database!"
		# 	;;
		# *)
			# echo "As of now we are serving following DBs only : $dbs"
			# break
			# ;;

	
			# : '
			# for word in $(< info_tables.txt)
			# do
			# 	    echo "$word"
			#     done '
			# ;;