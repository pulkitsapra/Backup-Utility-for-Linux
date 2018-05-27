#!bin/bash
SERVER_ADDR='192.168.43.123'

# ssh ~/Desktop/IMG_0199 sanidhya@192.168.43.123:/home/sanidhya/Desktop/

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
