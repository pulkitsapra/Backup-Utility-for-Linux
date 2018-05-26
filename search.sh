#!/bin/sh
array=($(ls -d */))
#echo $array
for (( idx=${#array[@]}-1 ; idx>=0 ; idx-- )) ; do
    a=($(find ${array[idx]} -type f -name $1| egrep '.*'))
    if [ $? -eq 0 ];then			    
    	    echo $a
	    break;
    fi
done
