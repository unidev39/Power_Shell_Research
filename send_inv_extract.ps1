######################################################################################################
# Credit Information Bureau Nepal Limited its affiliates. All rights reserved.
# File          : send_inv_extract.ps1
# Purpose       : To transfer files from Windows specified directory to Remote directory in Linux
# Usage         : powershell.exe -executionpolicy bypass -File C:\Users\devesh\Desktop\invoice_billing_system\send_inv_extract.ps1
# Created By    : Devesh Kumar Shrivastav
# Created Date  : Feb 21, 2021
# Purpose       : POC on Power Shell Transfer the files
# Revision      : 1.0
# Downloads     : https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html (putty-64bit-0.74-installer.msi and pscp.exe)
######################################################################################################
########################BOF This is part of the send_inv_extract######################################


# To export the Source and Dest File Information

# To Take parameters as argument
######################################################################################################
# For One Argument
# param($dest_user) 

# For Multipule Argument
# param($dest_user,$dest_ip,$dest_password,$ssh_port) 
######################################################################################################

$source_loaction = "C:\Users\devesh\Desktop\invoice_billing_system"
$filename = "INV_XXXXXXXX_XXXXXXXX.TXT"
$dest_user = "root"
$dest_ip = "192.168.129.1"
$dest_password = "P@ssw0rD"
$ssh_port = "22"
$dest_loaction = "/home/oracle/extracts"

# Find The Location of pscp.exe 
cd 'C:\Program Files\PuTTY\'

# Trasfer The File to Remote Server
pscp -P ${ssh_port} -pw ${dest_password} ${source_loaction}\${filename} ${dest_user}@${dest_ip}:${dest_loaction}/${filename}
	  
exit

########################EOF This is part of the send_inv_extract######################################