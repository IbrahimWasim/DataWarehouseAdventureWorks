######################
######################
######################

--DB CREATION:


CREATE DATABASE TESTING FROM sysadmin
    AS PERMANENT = 6000000,
       SPOOL = 12000000
       ;
	   

DROP DATABASE TESTING;

CREATE DATABASE DB FROM DBC
AS PERMANENT =100000000,
 SPOOL = 100000000;



CREATE DATABASE DB_STG1 FROM DBC
AS
PERMANENT = 10000000,
SPOOL = 2000000,
TEMPORARY = 2000000;




ALTER DATABASE DB
MODIFY SIZE 
AS  PERMANENT = 50000000,
  SPOOL = 50000000,
  TEMPORARY = 50000000;
  
MODIFY DATABASE DB_STG1
AS  PERMANENT = 9900000000,
  SPOOL = 40000000,
  TEMPORARY = 40000000;




MODIFY DATABASE DB_STG2
AS  PERMANENT = 2000000000,
  SPOOL = 40000000,
  TEMPORARY = 40000000;
  
  
######################
######################
######################
--tables in dbc

Sel * from dbc.tables
where databasename = 'DBC';

######################
######################
######################
--To check database all size

select
databasename,
sum(maxperm)/1e9,
sum(currentperm)/1e9
from dbc.allspace
group by 1






SELECT
  DatabaseName,
  SUM(MaxPerm)/1e9 AS MaxPerm_GB,
  SUM(CurrentPerm)/1e9 AS CurrentPerm_GB,
  SUM(MaxSpool)/1e9 AS MaxSpool_GB,
  SUM(CurrentSpool)/1e9 AS CurrentSpool_GB,
  SUM(MaxTemp)/1e9 AS MaxTemp_GB,
  SUM(CurrentTemp)/1e9 AS CurrentTemp_GB
FROM DBC.AllSpace
WHERE DatabaseName = 'DB'
GROUP BY 1;




######################
######################
######################
SELECT

DatabaseName,
SUM(MaxPerm)/(1024*1024*1024) (DECIMAL(15,6)) (TITLE 'Max Perm (GB)'),
SUM(CurrentPerm)/(1024*1024*1024) (DECIMAL(15,6)) (TITLE 'Current Perm (GB)'),
((SUM(CurrentPerm))/ NULLIFZERO (SUM(MaxPerm)) * 100) (DECIMAL(15,6)) (TITLE 'Percent Used')

FROM DBC.DiskSpace
WHERE MAXPERM >0
GROUP BY 1
ORDER BY 4 DESC




######################
######################
######################

SELECT
SessionNo,
UserName,
ClientIpAddress,
ClientProgramName,
ClientSystemUserId,
ClientOsName,
CASE
Transaction_Mode WHEN 'A' THEN 'ANSI'
				 WHEN 'T' THEN 'TDBS'
				 END AS TransactionMode,
CurIsolationLevel
FROM DBC.SessionInfoV
ORDER BY UserName;

######################
######################
######################



select
TABLENAME,
sum(maxperm)/1e6,
sum(currentperm)/1e6
from dbc.allspace
WHERE DATABASENAME= 'P_STGDB_T'
group by 1

######################
######################
######################




######################
######################
######################

--Modify DB:


20 gb space MODIFY DATABASE Dice AS PERM = 20e9;
--then Restart database
--Check space through
SELECT 
DatabaseName,
CAST(SUM( MaxPerm / 1000**3) AS DEC(9,2)) AS MaxPermGB,
CAST(SUM(CurrentPerm / 1000**3) AS DEC(9,2)) AS CurrentPermGB,
CAST(MAX(CurrentPerm) * (HASHAMP()+1) / 1000**3 AS DEC(9,2)) AS SkewedPermGB,
-- due to skewed tables 
MaxPermGB - SkewedPermGB AS AvailablePermGB
-- this space can be assigned to other databases
FROM dbc.DiskSpaceV
WHERE MaxPerm > 0 AND DatabaseName = 'Dice'
GROUP BY 1
ORDER BY AvailablePermGB DESC



