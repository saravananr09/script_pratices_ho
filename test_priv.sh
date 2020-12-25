#!/bin/bash
# ARRAY=( a b c d e f )
# read -p "Enter element : " K
# for E in ${ARRAY[@]}
# do	if [ "$K" = "$E" ]
#         then echo "$K found"
#         fi
# done

has_priv=(insert delete grant)
K='grant'
echo ${has_priv[$K]};
sleep 2
echo ${has_priv[@]};
# sleep 20
for E in "${!has_priv[@]}"; do
   if [[ "${has_priv[$E]}" = "${K}" ]]; then
       echo "${E} along with ${has_priv[$E]}";
       unset 'has_priv[$E]'
   fi
done
sleep 1
echo ${has_priv[*]};

# has_priv="$($mysql_con -e "select * from mysql.user where user='$user'\G" |grep 'Y'|awk '{print $1}'|cut -d ':' -f1)"
# K='Grant_priv'
# for E in ${has_priv[@]}
# do	if [ "$K" = "$E" ]
#         then 
#             echo "$K found"
#             echo -e "$user has\033[1;33m $K\e[0m (Grant option) Privilege ";
#             unset '${has_priv[  ]}'
#         fi
# done
#     printf "And $user has the following privileges also \n"
#     printf "\033[1;35m%s\e[0m \n" "$has_priv";








