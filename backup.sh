#current date
date=`date "+%Y-%m-%dT%H_%M_%S"`

#Fetch Client Data from backup_dir.txt

IFS=$'\n' read -d '' -r -a lines < backup_dir.txt
client_id=${lines[0]}
dest=${lines[1]}
ip=${lines[2]}
echo $client_id
echo $ip
echo $dest


# remaining.txt stores the unfinished commands and executes them in the next run.

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
        	# If the command again fails, it is put into temp.txt which is renamed to remaining.txt in the end.
        	echo $line >> temp.txt
        else
        	# deletes the successfully executed command from remaining.txt
        	sed -i.bak '1d' remaining.txt
        	# Stores the output (destination path of the successfull backup) in last_backup.txt
        	echo "$(cut -d':' -f2 <<<"$line")" > last_backup.txt


        fi
done <"$file"
mv temp.txt remaining.txt




counter=0
flag=0
last_backup=$(head -n 1 last_backup.txt )
length=$(wc -c <"last_backup.txt")


# Reads backup_files.txt for available directories to backup
while read -r line
do
	echo $line
	if [ "$length" -eq "0" ]; then
		#Level 0 backup for the first time
		comman="rsync -avzP $line  $client_id@$ip:$dest/$date"
	else
		#Level 1 Backup for subsequent time implemented via hardlinks
		comman="rsync -avzP --link-dest=$last_backup --delete $line  $client_id@$ip:$dest/$date"
		#comman="rsync -avzP $line  $client_id@$ip:$dest/$date"
	fi

	echo $comman

	# Tries to execute the command 2 times if it fails, falg is set to 1 and command is put in remaing.txt
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

# If Flag is 0 (No failure) the appends the dest path in last_backup.txt 
if [ "$flag" -eq "0" ]; then
	echo "Apeending in most recent backup"
	echo "$dest/$date" > last_backup.txt
fi




