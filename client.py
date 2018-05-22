import socket
import os
import subprocess
from optparse import OptionParser
from random import randint
# parser = OptionParser()
# parser.add_option("-x", dest="ip")
# options, parser = parser.parse_args()
# host_ip = str(options.ip)
host_ip='192.168.43.123'

def random_with_N_digits(n):
    range_start = 10**(n-1)
    range_end = (10**n)-1
    return randint(range_start, range_end)

id=random_with_N_digits(4)

#def find(name, path):
#    for root, dirs, files in os.walk(path):
#        if name in files:
#            return os.path.join(root, name)
#if find('temp.pub','.'):
#    echo "already has public key"
#else:
#    print "start"
#    subprocess.call("keygen.sh")
#    print "end"

subprocess.call(["bash","keygen.sh"])


s = socket.socket()

port =10103
# host_ip = socket.gethostbyname('www.google.com')
try:
	s.connect((host_ip,port))
	print "the socket has successfully connected to Backup Server IP == %s" %(host_ip)

except socket.error as err:
	print err

f = open('/Users/pulkit/Desktop/sysproj/temp.pub','r')
print "Sending Key to Server"

j = "-";
s.send(str(id))
l=f.read(8192)
while(l):
	print 'Sending...'
	s.send(l)
	l = f.read(8192)

# try:
# 	s.send(message)
# except socket.error as err:
# 	print err


client_id=s.recv(1024)
data=s.recv(1024)
ip=s.recv(1024)
print  data,
print  ip,
# print  data,'\n'
f.close()
with open('/Users/pulkit/Desktop/sysproj/backup_dir.txt','w') as the_file:
   # the_file.write(client_id)
    the_file.write(ip)
    the_file.write(data)
f.close()


s.close()
