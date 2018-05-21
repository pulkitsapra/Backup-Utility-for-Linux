client_folder_name="Desktop/sysproj"
client_id="temp" 


#Checking whether temp.pub is already generated
if [ "`ls ~/$client_folder_name/ | grep $client_id.pub`" != "$client_id.pub" ]
then
	#echo "not present"
	cd ~/.ssh
	if [ "`ls  | grep id_rsa.pub`" != "id_rsa.pub" ]
	then
		ssh-keygen -t rsa -N "" -f id_rsa 
		chmod 600 ~/.ssh/id_rsa
		chmod 600 ~/.ssh/id_rsa.pub
		echo "key generated"
	else
		echo "copying existing key from .ssh"
	fi
	#Press Enters 
	#eval `ssh-agent -s`

	#adds private key identities to the authentication agent
	#ssh-add ~/.ssh/$client_id
	cp ~/.ssh/id_rsa.pub  ~/$client_folder_name/temp.pub 
# 	cp ~/.ssh/id_rsa.pub ~/$client_folder_name/temp.pub 
	
else
	echo "Key already present"
fi
