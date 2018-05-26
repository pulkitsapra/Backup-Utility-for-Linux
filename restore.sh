#/bin/sh

IFS=$'\n' read -d '' -r -a lines < backup_dir.txt
client_id=${lines[0]}
dest=${lines[1]}
ip=${lines[2]}

ssh "$client_id"@"$ip" "bash -s " $1 -- < search.sh > a.txt



actualsize=$(wc -c <"a.txt")

if [ "$actualsize" -eq "0" ];
then
	echo "Given file not found"
else
	while read -r line
	do
		echo $line
	 	rsync -avzP --stats $client_id@$ip:$line  $2
	 	echo "File successfully restored in directory $2"
	done<a.txt
	
fi

   
