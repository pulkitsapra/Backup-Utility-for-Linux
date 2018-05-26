date=`date "+%Y-%m-%dT%H:%M:%S"`
# while read -r LINE || [[ -n $LINE ]]; do
# dest=line
# done <backup_dir.txt

IFS=$'\n' read -d '' -r -a lines < backup_dir.txt
client_id=${lines[0]}
dest=${lines[1]}
ip=${lines[2]}
echo $client_id
echo $ip
echo $dest
while read -r line
do
	 rsync -e "ssh -o StrictHostKeyChecking=no" -avzP $line  $client_id@$ip:$dest/$date
	# echo $line

done<backup_files.txt