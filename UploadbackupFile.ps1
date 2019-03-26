#########################################################################################
# Eightsquare Pvt. Ltd. Nepal its affiliates. All rights reserved. 
# File         : UploadbackupFile.ps1
# Purpose      : To Push the Backup File from Windows to Linux - (ftp)
# Usage        : ./UploadbackupFile.ps1
# Created By   : Devesh Kumar Shrivastav
# Created Date : March 26, 2019
# Review By    : Suman Pantha
# Review Date  : March 26, 2019
# Purpose      : POC on UNIX automation of Backup File Push process
# Revision     : 1.0
#########################################################################################

################BOF This is part of the UploadbackupFile#################

# To export the FTP Server Information
$ftp = "ftp://192.168.159.130/BackUp/" 
$user = "ftptest" 
$pass = "ftptest"  
$destdir = "C:\cygwin\POC\Copy_Backup\"
$filenamelike = '*' + [datetime]::Today.ToString('_yyyy_MM_dd_') + '*.bak'
 
$webclient = New-Object System.Net.WebClient
$webclient.Credentials = New-Object System.Net.NetworkCredential($user,$pass)  
 
#List Every sql server txt file 
foreach($item in (dir $destdir "$filenamelike")){ 
    "Uploading $item..." 
    $uri = New-Object System.Uri($ftp+$item.Name) 
    $webclient.UploadFile($uri, $item.FullName)
}