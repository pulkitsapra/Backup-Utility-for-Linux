#!bin/bash
SERVER_ADDR='192.168.4.123'


# fs=`df -kh |grep -v "Size" | awk '{ print $4 }' | sed 's/Gi//g ; s/Bi//g'`
# dr=`df -kh |grep -v "Size" | awk '{ print $1 }' | sed 's/Gi//g ; s/Bi//g'`
# for (( i=0; i<${#fs[@]}; i++ )); do echo ${fs[i]}; done
# echo
# printf "%s\n" "${lines[@]}"
# echo ${#fs[@]}
# echo $dr


# if grep -Fxq "192.168.42.123" a.txt
# then
#     echo "hello"
# else
#     echo "bye"
# fi

# rsync -avze ssh ~/Desktop/IMG_0199 sanidhya@192.168.43.123:/home/sanidhya/Desktop/

while read p;do
	ssh -o PasswordAuthentication=no  -o BatchMode=yes -o StrictHostKeyChecking=no sanidhya@$p exit &>/dev/null
	RESULT=$? 


	if [ $RESULT -eq 0 ]; then
		echo "SSH Possible for manager: ${p} "
 		
	else
		echo "Passwordless SSH Failed"
		/usr/bin/python client.py -x $p
		wait
		echo "SSH Key has been passed"
		ssh -o PasswordAuthentication=no  -o BatchMode=yes -o StrictHostKeyChecking=no sanidhya@$p exit &>/dev/null
		echo "SSH Possible"
		wait


	fi
done<servers.txt	
