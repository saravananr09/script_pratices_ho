#!/bin/bash 
#  set -x
MYSQL="/mnt/e/back/vicky/mysql_base/bin"
USER="root"
SOCKET="/tmp/mysql78.sock"
mysql_con="$MYSQL/mysql -u $USER -S $SOCKET"

read -p "Enter the user name " user;
has_priv=($($mysql_con -e "select * from mysql.user where user='$user'\G" |grep 'Y'|awk '{print $1}'|cut -d ':' -f1))
grant='Grant_priv'

for priv_i in "${!has_priv[@]}"; do
   if [[ "${has_priv[$priv_i]}" = "${grant}" ]]; then
       echo -e "$user is Privileged with \033[1;33m $grant\e[0m (Grant option) ";
       unset 'has_priv[$priv_i]'
   fi
done  
    printf "Also, $user has the following privileges \n"
    printf "\033[1;35m%s\e[0m \n" "${has_priv[@]}";





    


# for E in ${!has_priv[@]}
# do	if [ "$K" = "$E" ]
#         then 
#             echo "$K found"
#             echo -e "$user has\033[1;33m $K\e[0m (Grant option) Privilege ";
#             unset 'has_priv[$E]'
#         fi
#     printf "And $user has the following privileges also \n"
#     printf "\033[1;35m%s\e[0m \n" "$has_priv";
# done


# for i in $has_priv
# do
#     if [ $i == 'Grant_priv']
#     then 
#         echo "$user has privileged with grant option !";
#     else
#         prives+=$i;
#     fi
# done 
# echo -e "$prives \n";



    # echo -e "\n$user user has following privileges \n$i";

# for i in $has_priv
# do 
#     echo $i : 'Y';
# done






# withthehelpoftextfile
# $($mysql_con -e "select * from mysql.user where user='saravanan'\G" > userpriv.txt)

# priv=`grep 'priv' userpriv.txt`

# filtered=$(less userpriv.txt |grep 'Y'|awk '{print $1}'|cut -d ':' -f1)

# echo $filtered;













# for privs in $priv
# do 
# echo $privs
# done

# priv="GRANT SELECT, INSERT, UPDATE, DELETE ON '*.*' TO 'saravanan'@'localhost' WITH GRANT OPTION"
#  set -x
# priv=$($mysql_con -sN -e 'show grants for 'saravanan'@localhost;'  )
# # | awk '{print $2}'
# ss=`cut $priv -d ',' -f 1-3`
# echo $ss;




# read -p "Enter the user name " user;
# has_priv=($($mysql_con -e "select * from mysql.user where user='$user'\G" |grep 'Y'|awk '{print $1}'|cut -d ':' -f1))
# echo ${!has_priv[@]};
# echo ${has_priv[@]};
# # set -x
# # echo $has_priv;
# K='Grant_priv'

# echo ${has_priv[$K]};
# sleep 2
# echo ${has_priv[@]};
# # sleep 20
# for E in "${!has_priv[@]}"; do
#    if [[ "${has_priv[$E]}" = "${K}" ]]; then
#        echo "${E} along with ${has_priv[$E]}";
#        unset 'has_priv[$E]'
#    fi
# done
# sleep 1
# echo ${has_priv[*]};



