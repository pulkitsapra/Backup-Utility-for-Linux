
IFS=$'\n' read -d '' -r -a lines < backup_dir.txt
client_id=${lines[0]}
dest=${lines[1]}
ip=${lines[2]}
echo $client_id
echo $ip
echo $dest

# Shows the content of a backup directory as a Recursive Tree

ssh $client_id@$ip 'cd $1 && ls -R'
