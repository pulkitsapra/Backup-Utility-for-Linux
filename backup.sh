date=`date "+%Y-%m-%dT%H:%M:%S"`
# while read -r LINE || [[ -n $LINE ]]; do
# dest=line
# done <backup_dir.txt

IFS=$'\n' read -d '' -r -a lines < backup_dir.txt
ip=${lines[0]}
dest=${lines[1]}
echo $ip
echo $dest
# while read path;do
# 	rsync -avzP $path  dlgroup4@40.115.126.22:~/$date

# done<backup_files.txt