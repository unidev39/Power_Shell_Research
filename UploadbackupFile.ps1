################BOF This is part of the UploadbackupFile#################

# To export the FTP Server Information
$ftp = "ftp://192.168.159.130/BackUp/" 
$user = "ftptest" 
$pass = "ftptest"  
$sourcetdir = "C:\cygwin\POC\Copy_Backup\"
$filenamelike = '*' + [datetime]::Today.ToString('_yyyy_MM_dd_') + '*.bak'
 
$webclient = New-Object System.Net.WebClient
$webclient.Credentials = New-Object System.Net.NetworkCredential($user,$pass)  
 
#List Every sql server txt file 
foreach($item in (dir $sourcetdir "$filenamelike")){ 
    "Uploading $item..." 
    $uri = New-Object System.Uri($ftp+$item.Name) 
    $webclient.UploadFile($uri, $item.FullName)
}
