# Backup-Utility-for-Linux

//Steps to run the code



Make sure you have rsync installed in your machine and the manager, backup nodes and client are on same network



//THINGS TO BE DONE AT MANAGER
*Run server_listen.py at a certain port which client should know*
*Manager should have all the space info and ip's for all backup servers*



//CLIENT
//FIRST CONNECTION

*In 'client.py' change the host_ip and port*

1) Run 'python client.py' to establish the first connection with the manager. You will recieve the following in your "backup_dir.txt"


   1.1) Client id : Randomly generated id given by the manager
   1.2) IP : Destination Ip of Backup Server.
   1.3) Home Directory Path : /home/client_id will be returned by the manager

//BACKUP

2) Specify the directories you want to backup in backup_files.txt

3) Run './backup.sh' every time you want to backup

4) Backups will be created according to date

5) You can put 'backup.sh' in crontab and run every day


//RESTORE

6) If you want the latest version of a file, Run './restore.sh {Name of file to be restored} {path on your machine where you want it to be restored}'

7) If you want a specific file from a particular date, run './restore_sp.sh {Date} {Name of file} {path on your machine where you want it to be restored}'

//SHOW

8) Run './show.sh to get a list of files in a particular directory







