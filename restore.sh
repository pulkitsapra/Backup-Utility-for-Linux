#/bin/sh

# Fetches client information

IFS=$'\n' read -d '' -r -a lines < backup_dir.txt
client_id=${lines[0]}
dest=${lines[1]}
ip=${lines[2]}
echo $1

# Remotely executes 'search.sh' on server and stores the reply in 'a.txt'

ssh "$client_id"@"$ip" "bash -s " "$1" -- < search.sh > a.txt


# Size of a.txt
actualsize=$(wc -c <"a.txt")

# If a.txt is empty then file is not found, else rsync's the latest version of that file into the specified directory on the client's machine

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

   
