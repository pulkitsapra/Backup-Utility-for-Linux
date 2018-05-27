#current date
date=`date "+%Y-%m-%dT%H_%M_%S"`

#

IFS=$'\n' read -d '' -r -a lines < backup_dir.txt
client_id=${lines[0]}
dest=${lines[1]}
ip=${lines[2]}
echo $client_id
echo $ip
echo $dest



file="remaining.txt"
ssh -o PasswordAuthentication=no  -o BatchMode=yes -o StrictHostKeyChecking=no client_id@$ip exit &>/dev/null
while IFS= read line
do
        # display $line or do somthing with $line
        echo "$line"
        #ssh -o PasswordAuthentication=no  -o BatchMode=yes -o StrictHostKeyChecking=no client_id@$ip exit &>/dev/null
        $line
        if [ $? -ne "0" ]
        then
        	echo $line >> temp.txt
        else
        	sed -i.bak '1d' remaining.txt
        	echo "$(cut -d':' -f2 <<<"$line")" > last_backup.txt


        fi
done <"$file"
mv temp.txt remaining.txt


counter=0
flag=0
last_backup=$(head -n 1 last_backup.txt )
length=$(wc -c <"last_backup.txt")


while read -r line
do
	echo $line
	if [ "$length" -eq "0" ]; then
		comman="rsync -avzP $line  $client_id@$ip:$dest/$date"
	else
		comman="rsync -avzP --link-dest=$last_backup --delete $line  $client_id@$ip:$dest/$date"
		#comman="rsync -avzP $line  $client_id@$ip:$dest/$date"
	fi

	echo $comman

	while ! $comman
	do
		echo "trying"
		if [ "$counter" -eq "1" ]; then
			echo $comman >> remaining.txt
			flag=1
			break
		fi
		counter=$((counter+1))
	done
done<backup_files.txt

if [ "$flag" -eq "0" ]; then
	echo "Apeending in most recent backup"
	echo "$dest/$date" > last_backup.txt
fi




