#/bin/sh

# Restore a specific file in a given directory.

IFS=$'\n' read -d '' -r -a lines < backup_dir.txt
client_id=${lines[0]}
dest=${lines[1]}
ip=${lines[2]}

#1 : date from which you want to restore the backup
#2 : name of the file
#3 : path on your machine where you want to restore it 

ssh "$client_id"@"$ip" "bash -s " $1 $2 -- < search_refined.sh > b.txt

while read -r line
do
	echo $line
 	rsync -avzP --stats $client_id@$ip:$line  $3
 	echo "File successfully restored in directory $2"
done<b.txt


# rsync -avzP --stats $client_id@$ip:$a $3