################BOF This is part of the DounloadbackupFile#################

# To export the FTP Server Information

$ftp = "ftp://192.168.159.130" 
$user = 'ftptest' 
$pass = 'ftptest'
$folder = 'BackUp'
$target = "C:\cygwin\POC\Restore_Backup\"
$filenamelike = '*' + [datetime]::Today.ToString('_yyyy_MM_dd_') + '*.bak'

#To Set the Linux(ftp) Credentials
$credentials = new-object System.Net.NetworkCredential($user, $pass)

#To Create a Function to Pull the File from Linux(ftp)
function Get-FtpDir ($url,$credentials) {
    $request = [Net.WebRequest]::Create($url)
    $request.Method = [System.Net.WebRequestMethods+FTP]::ListDirectory
    if ($credentials) { $request.Credentials = $credentials }
    $response = $request.GetResponse()
    $reader = New-Object IO.StreamReader $response.GetResponseStream() 
    while(-not $reader.EndOfStream) {
        $reader.ReadLine()
    }
    $reader.Close()
    $response.Close()
}

#To Set the Linux(ftp) Path
$folderPath= $ftp + "/" + $folder + "/"

#To Get the List of File from Linux(ftp) Path
$files = Get-FTPDir -url $folderPath -credentials $credentials

$webclient = New-Object System.Net.WebClient 
$webclient.Credentials = New-Object System.Net.NetworkCredential($user,$pass) 
$counter = 0

#To Look into all Files of Linux(ftp) Path
foreach ($file in ($files | where {$_ -like $filenamelike})){
    $source=$folderPath + $file  
    $webclient.DownloadFile($source, $target+$file)
    $counter++
}
