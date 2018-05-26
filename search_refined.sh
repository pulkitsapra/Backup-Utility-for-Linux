a=($(find $1 -type f -name $2| egrep '.*'))
if [ $? -eq 0 ];then			    
   	echo $a
	  
fi