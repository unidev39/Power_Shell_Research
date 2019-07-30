#########################################################################################
# Eightsquare Pvt. Ltd. Nepal its affiliates. All rights reserved. 
# File         : VerifyBackupDatabase.ps1
# Purpose      : To verify the current Backup Database
# Usage        : ./VerifyBackupDatabase.ps1
# Created By   : Devesh Kumar Shrivastav
# Created Date : July 02, 2019
# Review By    : Suman Pantha
# Review Date  : July 02, 2019
# Revision     : 1.0
################################################################################################################

#####################################BOF This is part of the VerifyBackupDatabase###############################

$Server = "M1SGSDDCSVR08\MSSQLM1REMITUAT"
$Database = "M1Remit_Preprod"
$Username = "########"
$Password = "########"
$Query = "SELECT
          	   s.name AS schemaname,
          	   t.name AS tablename,
          	   p.rows AS rowcounts,
          	   CAST(ROUND((SUM(a.used_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS used_mb,
          	   CAST(ROUND((SUM(a.used_pages) / 128.00), 2) AS NUMERIC(36, 2)) / 1024 AS used_gb,
          	   CAST(ROUND((SUM(a.total_pages) - SUM(a.used_pages)) / 128.00, 2) AS NUMERIC(36, 2)) AS unused_mb,
          	   CAST(ROUND((SUM(a.total_pages) / 128.00), 2) AS NUMERIC(36, 2)) AS total_mb
          FROM sys.tables t INNER JOIN sys.indexes i ON t.object_id = i.object_id
          INNER JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
          INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
          INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
          GROUP BY t.name, s.name, p.Rows
          ORDER BY 5 DESC"
$FilePath = "E:\VerifyBackupDatabase\VerifyBackupDatabase.csv"

# This will overwrite the file if it already exists.
Invoke-Sqlcmd -Query $Query -Database $Database -ServerInstance $Server -Username $Username -Password $Password | Export-Csv $FilePath

################################################################################################################
#                                                 End of Script                                                #
################################################################################################################
