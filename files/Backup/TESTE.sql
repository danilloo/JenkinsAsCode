USE [TESTE]
GO
 
   DECLARE @BackupFileName       varchar(100) 
   DECLARE @DBName               sysname 
   DECLARE @S3ARN_Prefix         nvarchar(100) 
   DECLARE @S3ARN                nvarchar(100) 
  
   SET @S3ARN_Prefix = 'arn:aws:s3:::backup/TESTE/'
   SET @DBName = (SELECT DB_NAME() AS [Current Database]);

         SET @BackupFileName = @DBName + '_' + REPLACE(REPLACE(REPLACE(CONVERT(varchar,GETDATE(),20),'-',''),':',''),' ','') + '.bak' 
         SET @S3ARN = @S3ARN_Prefix + @BackupFileName 
      
         EXEC msdb.dbo.rds_backup_database 
              @source_db_name = @DBName, 
              @S3_arn_to_backup_to = @S3ARN, 
              @overwrite_S3_backup_file = 0,
              @type = 'FULL'
GO
