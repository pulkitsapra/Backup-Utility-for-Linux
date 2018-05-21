import socket
import os
import subprocess
from optparse import OptionParser

parser = OptionParser()
parser.add_option("-x", dest="ip")
options, parser = parser.parse_args()
host_ip = str(options.ip)

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

#host_ip='192.168.43.123'
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
l=f.read(1024)
while(l):
	print 'Sending...'
	s.send(l)
	l = f.read(1024)

# try:
# 	s.send(message)
# except socket.error as err:
# 	print err
data=s.recv(1024)
print data


s.close()
