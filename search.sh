#!/bin/sh
cd ~/Desktop/sysproj
array=($(ls -d */))
for (( idx=${#array[@]}-1 ; idx>=0 ; idx-- )) ; do
    #echo "${array[idx]}"
    a=($(find ${array[idx]} -type f -name 'LF*'| egrep '.*'))
    if [ $? -eq 0 ];then			    
    	    echo $a
	    break;
    fi
done
