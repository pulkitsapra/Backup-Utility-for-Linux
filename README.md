# Backup-Utility-for-Linux

This utility is built on the top of rsync to implement periodic incremental backups for every date. One can also restore latest / a specific version of a particular file using the same package.

## Steps to run the code

- Make sure you have rsync installed in your machine and the manager, backup nodes and client are on same network


### Things to be done at Manager Node
- Run server_listen.py at a certain port which client should know
- Manager should have all the space info and ip's for all backup servers



## Client

- In 'client.py' change the host_ip and port

- Run 'python client.py' to establish the first connection with the manager. You will recieve the following in your "backup_dir.txt"

  - Client id : Randomly generated id given by the manager
  - IP : Destination Ip of Backup Server.
  - Home Directory Path : /home/client_id will be returned by the manager

## Backup

- Specify the directories you want to backup in backup_files.txt

- Run './backup.sh' every time you want to backup

- Backups will be created according to date

- You can put 'backup.sh' in crontab and run every day


## Restore

- If you want the latest version of a file, Run './restore.sh {Name of file to be restored} {path on your machine where you want it to be restored}'

- If you want a specific file from a particular date, run './restore_sp.sh {Date} {Name of file} {path on your machine where you want it to be restored}'

## Show

- Run './show.sh to get a list of files in a particular directory







