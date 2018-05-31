import socket
import os
import subprocess
from optparse import OptionParser
from random import randint 

# The Manager Address and port 

host_ip='192.168.43.123'
port =10106

# Generates a random number say xxxx then its client id becomes 'clxxxx' and home directory made at the server as '/home/clxxxx' with permissions 700
def random_with_N_digits(n):
    range_start = 10**(n-1)
    range_end = (10**n)-1
    return randint(range_start, range_end)

id=random_with_N_digits(4)
id="cl"+ str(id)

# Looks for a public key in .ssh folder if temp.pub not present. If not found generates a ssh public private key and sends it to manager which then copies it to the server
subprocess.call(["bash","keygen.sh"])


s = socket.socket()
try:
	s.connect((host_ip,port))
	print "the socket has successfully connected to Backup Server IP == %s" %(host_ip)

except socket.error as err:
	print err

f = open('temp.pub','r')
print "Sending Key to Server"

j = "-";
s.send(str(id))
l=f.read(8192)
while(l):
	print 'Sending...'
	s.send(l)
	l = f.read(8192)

try:
    client_id=s.recv(1024)
    data=s.recv(12)
    ip=s.recv(24)
    print  client_id,
    print  data, ip
except:
    print "An Unknown Error Occurred!"

f.close()

# Writes the parameters of client in the file 'backup_dir.txt'
with open('backup_dir.txt','w') as the_file:
    the_file.write(client_id)
    the_file.write('\n')
    the_file.write(data)
    the_file.write('\n')
    the_file.write(ip)
    the_file.write('\n')
f.close()


s.close()
