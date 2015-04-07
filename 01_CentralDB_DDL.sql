USE [master]
GO
/****** Object:  Database [CentralDB]    Script Date: 4/7/2014 3:15:32 PM ******/
/**Please change the FileName path for the DB creation to appropriate one**/
CREATE DATABASE [CentralDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CentralDB', FILENAME = N'C:\CentralDB\CentralDB.mdf' , SIZE = 1572864KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1048576KB )
 LOG ON 
( NAME = N'CentralDB_log', FILENAME = N'C:\CentralDB\CentralDB_log.ldf' , SIZE = 262144KB , MAXSIZE = 2048GB , FILEGROWTH = 524288KB )
GO
ALTER DATABASE [CentralDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CentralDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CentralDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CentralDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CentralDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CentralDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CentralDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [CentralDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CentralDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [CentralDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CentralDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CentralDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CentralDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CentralDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CentralDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CentralDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CentralDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CentralDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CentralDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CentralDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CentralDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CentralDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CentralDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CentralDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CentralDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CentralDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CentralDB] SET  MULTI_USER 
GO
ALTER DATABASE [CentralDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CentralDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CentralDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CentralDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'CentralDB', N'ON'
GO
USE [CentralDB]
GO
/****** Object:  Schema [AS]    Script Date: 4/7/2014 3:15:33 PM ******/
CREATE SCHEMA [AS]
GO
/****** Object:  Schema [DB]    Script Date: 4/7/2014 3:15:33 PM ******/
CREATE SCHEMA [DB]
GO
/****** Object:  Schema [Inst]    Script Date: 4/7/2014 3:15:33 PM ******/
CREATE SCHEMA [Inst]
GO
/****** Object:  Schema [IS]    Script Date: 4/7/2014 3:15:33 PM ******/
CREATE SCHEMA [IS]
GO
/****** Object:  Schema [RS]    Script Date: 4/7/2014 3:15:33 PM ******/
CREATE SCHEMA [RS]
GO
/****** Object:  Schema [Svr]    Script Date: 4/7/2014 3:15:33 PM ******/
CREATE SCHEMA [Svr]
GO
/****** Object:  StoredProcedure [dbo].[usp_ASDBInfo]    Script Date: 4/7/2014 3:15:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_ASDBInfo]
(
@InstanceName varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--AS DB info
SELECT y.ServerName, y.InstanceName, y.DBName, y.DBSizeInMB, y.Collation, y.CompatibilityLevel, y.DBCreateDate, 
 CASE WHEN  y.DBLastProcessed = '12/30/1699 4:00:00 PM' Then 'Never'ELSE y.DBLastProcessed End as DBLastProcessed, 
y.DBLastUpdated, y.DBStorageLocation, y.NoOfCubes, y.NoOfDimensions, y.ReadWriteMode, y.StorgageEngineUsed, y.DateAdded
FROM     (SELECT InstanceName, MAX(DateAdded) AS Rundate
                  FROM      [AS].SSASDBInfo
                  GROUP BY InstanceName) AS x INNER JOIN
                  [AS].SSASDBInfo AS y ON x.Rundate = y.DateAdded AND x.InstanceName = y.InstanceName AND y.InstanceName = @InstanceName
END



GO
/****** Object:  StoredProcedure [dbo].[usp_ASInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[usp_ASInfo]
(
@InstanceName varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--AS Instance info
  SELECT y.ServerName, y.InstanceName, y.ASVersion, Y.ASPatchLevel, Y.ASEdition, Y.ASVersionNo, Y.NoOfDBs, Y.LastSchemaUpdate, y.DateAdded
FROM     (SELECT InstanceName, MAX(DateAdded) AS Rundate
                  FROM      [AS].[SSASInfo]
                  GROUP BY InstanceName) AS x INNER JOIN
                  [AS].[SSASInfo] AS y ON x.Rundate = y.DateAdded AND x.InstanceName = y.InstanceName AND y.InstanceName = @InstanceName
END



GO
/****** Object:  StoredProcedure [dbo].[usp_ASOverview]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[usp_ASOverview]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Serverinfo View
Select z.InstanceName, z.ASVersion, z.ASPatchLevel, z.IsSPUpToDateOnAS,z.ASEdition, z.NoOfDBs, v.Environment from (
select  y.* from(
select InstanceName, Max(DateAdded) as Rundate 
from [CentralDB].[AS].[SSASInfo]
Group BY InstanceName) x
Join [CentralDB].[AS].[SSASInfo] y ON x.Rundate = y.DateAdded and X.InstanceName = y.InstanceName) z
inner join(
select Distinct ServerName, InstanceName, Environment, Description, BusinessOwner from  [CentralDB].[Svr].[ServerList]) v ON Z.InstanceName = V.InstanceName
END


GO
/****** Object:  StoredProcedure [dbo].[usp_DBFiles]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_DBFiles]
(
@InstanceName varchar(128),
@DBName varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--DB Files Info
SELECT Y.LogicalName, Y.PhysicalName, (SUBSTRING(REVERSE(Y.PhysicalName), 1, CHARINDEX('.', REVERSE(Y.PhysicalName)) - 1)) AS [File Type],
		y.SizeInMB, y.GrowthPct, y.GrowthInMB
FROM     (SELECT InstanceName, MAX(DateAdded) AS Rundate
                  FROM      [DB].[DatabaseFiles]
                  GROUP BY InstanceName) AS x INNER JOIN
                  [DB].[DatabaseFiles] AS y ON x.Rundate = y.DateAdded AND x.InstanceName = y.InstanceName  AND y.InstanceName = @InstanceName And  y.DBName = @DBName
END



GO
/****** Object:  StoredProcedure [dbo].[usp_DBGrwth]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_DBGrwth]
(
@InstanceName varchar(128),
@DBName varchar(128),
@StartDate DateTime,
@EndDate DateTime
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- in@InstanceNameterfering with SELECT statements.
	SET NOCOUNT ON;
--Database growth info
SELECT       InstanceName, [DBName],[DataFileInMB],[LogFileInMB], [DataFileInMB] + [LogFileInMB] as DBGrowth, DateAdded-- CONVERT(char(10), DateAdded, 101) as DateAdded
  FROM [CentralDB].[DB].[DBFileGrowth] where InstanceName = @InstanceName And DBName= @DBName and (DateAdded >= @StartDate) AND (DateAdded <= @EndDate)
END



GO
/****** Object:  StoredProcedure [dbo].[usp_DBGrwth30Day]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_DBGrwth30Day]
(
@InstanceName varchar(128),
@DBName varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Database growth for past 30 days info
SELECT [DataFileInMB] + [LogFileInMB] as DBGrowth, DateAdded --CONVERT(char(10), DateAdded, 101) as DateAdded
  FROM [CentralDB].[DB].[DBFileGrowth] where InstanceName = @InstanceName And DBName= @DBName and DateAdded > getdate()-30
END



GO
/****** Object:  StoredProcedure [dbo].[usp_DBInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_DBInfo]
(
@InstanceName varchar(128),
@DBName varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Instance info
SELECT y.InstanceName, y.DBName, y.DBStatus, y.DBOwner, y.DBCreateDate, y.DBSizeInMB, y.DBSpaceAvailableInMB, y.DBUsedSpaceInMB, y.DBPctFreeSpace, 
                  y.DBDataSpaceUsageInMB, y.DBIndexSpaceUsageInMB, y.Collation, y.RecoveryModel, y.CompatibilityLevel,  
				  y.AutoShrink, y.AutoUpdateStatisticsEnabled, y.IsReadCommittedSnapshotOn, y.IsFullTextEnabled, y.BrokerEnabled, 
                  y.ReadOnly, y.IsDatabaseSnapshot,  y.IsMirroringEnabled, y.MirroringPartnerInstance, y.MirroringStatus, 
                  y.MirroringSafetyLevel, y.ReplicationOptions, y.AvailabilityGroupName, y.NoOfTbls, y.NoOfViews, y.NoOfStoredProcs, y.NoOfUDFs, y.NoOfLogFiles, y.NoOfFileGroups, 
                  y.NoOfUsers, y.NoOfDBTriggers, y.DateAdded, 
                  CASE WHEN y.LastBackupDate = '1/1/0001 12:00:00 AM' THEN 'No Full Backup Taken Yet' ELSE y.LastBackupDate END AS FullBackup, 
				  CASE WHEN y.LastDifferentialBackupDate = '1/1/0001 12:00:00 AM' THEN 'No Diff Backup Taken Yet' ELSE y.LastDifferentialBackupDate END AS DiffBackup, 
				  CASE WHEN y.LastLogBackupDate = '1/1/0001 12:00:00 AM' THEN 'No Log Backup Taken Yet' ELSE y.LastLogBackupDate END AS LogBackup 
FROM     (SELECT InstanceName, MAX(DateAdded) AS Rundate
                  FROM      DB.DatabaseInfo
                  GROUP BY InstanceName) AS x INNER JOIN
                  DB.DatabaseInfo AS y ON x.Rundate = y.DateAdded AND x.InstanceName = y.InstanceName AND y.InstanceName = @InstanceName And  y.DBName = @DBName
END



GO
/****** Object:  StoredProcedure [dbo].[usp_DBTriggers]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[usp_DBTriggers]
(
@InstanceName varchar(128),
@DBName varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--DB Trigger info
SELECT y.InstanceName, y.TriggerName, y.CreateDate, y.LastModified, y.IsEnabled, y.DateAdded
FROM     (SELECT InstanceName, MAX(DateAdded) AS Rundate
                  FROM      [DB].[Triggers]
                  GROUP BY InstanceName) AS x INNER JOIN
                  [DB].[Triggers] AS y ON x.Rundate = y.DateAdded AND x.InstanceName = y.InstanceName AND y.InstanceName = @InstanceName And  y.DBName = @DBName
END



GO
/****** Object:  StoredProcedure [dbo].[usp_DelData]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_DelData]
(
	  @DelInv SMALLINT,
	  @DelGrwth SMALLINT,
	  @DelStats SMALLINT,
      @DelCntr SMALLINT

)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Delete Old Data
Delete From [AS].[SSASDBInfo] Where DateAdded < GETDATE()- @DelInv;
Delete From [AS].[SSASInfo] Where DateAdded < GETDATE()- @DelInv;
Delete From [DB].[DatabaseFiles] Where DateAdded < GETDATE()- @DelInv;
Delete From [DB].[DatabaseInfo] Where DateAdded < GETDATE()- @DelInv;
Delete From [DB].[DBFileGrowth] Where DateAdded < GETDATE()- @DelGrwth;
Delete From [DB].[DBUserRoles] Where DateAdded < GETDATE()- @DelInv;
Delete From [DB].[Triggers] Where DateAdded < GETDATE()- @DelInv;
Delete From [Inst].[InsBaselineStats] Where RunDate < GETDATE()- @DelCntr;
Delete From [Inst].[InstanceInfo] Where DateAdded < GETDATE()- @DelInv;
Delete From [Inst].[InstanceRoles] Where DateAdded < GETDATE()- @DelInv;
Delete From [Inst].[InsTriggers] Where DateAdded < GETDATE()- @DelInv;
Delete From [Inst].[Jobs] Where DateAdded < GETDATE()- @DelInv;
Delete From [Inst].[LinkedServers] Where DateAdded < GETDATE()- @DelInv;
Delete From [Inst].[Logins] Where DateAdded < GETDATE()- @DelInv;
Delete From [Inst].[MissingIndexes] Where DateAdded < GETDATE()- @DelStats;
Delete From [Inst].[WaitStats] Where DateAdded < GETDATE()- @DelStats;
Delete From [RS].[SSRSConfig] Where DateAdded < GETDATE()- @DelInv;
Delete From [RS].[SSRSInfo] Where DateAdded < GETDATE()- @DelInv;
Delete From [Svr].[DiskInfo] Where DateAdded < GETDATE()- @DelGrwth;
Delete From [Svr].[OSInfo] Where DateAdded < GETDATE()- @DelInv;
Delete From [Svr].[PgFileUsage] Where DateAdded < GETDATE()- @DelInv;
Delete From [Svr].[ServerInfo] Where DateAdded < GETDATE()- @DelInv;
Delete From [Svr].[SQLServices] Where DateAdded < GETDATE()- @DelInv;
Delete From [Svr].[SvrBaselineStats] Where RunDate < GETDATE()- @DelCntr;

END


GO
/****** Object:  StoredProcedure [dbo].[usp_DiskGrwth]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_DiskGrwth]
(
@ServerName varchar(128),
@StartDate DateTime,
@EndDate DateTime
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Disk Growth info
select  ServerName, DiskName, DskTotalSizeInGB as TotalSizeInGB, [DskUsedSpaceInGB] as UsedSpaceInGB, DateAdded from [Svr].[DiskInfo] 
where ServerName =  @ServerName and (DateAdded >= @StartDate) AND (DateAdded <= @EndDate)

END



GO
/****** Object:  StoredProcedure [dbo].[usp_DiskInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[usp_DiskInfo]
(
@servername varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Disk Management info
select  y.DiskName, Y.DskClusterSizeInKB, y.DskTotalSizeInGB, y.[DskFreeSpaceInGB], y.[DskUsedSpaceInGB], y.[DskPctFreeSpace]  from(
select ServerName, Max(DateAdded) as Rundate 
from [Svr].[DiskInfo]
Group BY Servername) x
Join [Svr].[DiskInfo] y ON x.Rundate = y.DateAdded and X.ServerName = y.ServerName and y.ServerName =  @servername

END



GO
/****** Object:  StoredProcedure [dbo].[usp_InstChrtWaitStats]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_InstChrtWaitStats]
(
@InstanceName varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Instance Wait Stats info
SELECT DISTINCT WaitType, COUNT(WaitType) AS count
FROM     [Inst].[WaitStats]
WHERE  (InstanceName = @InstanceName) --and (DateAdded > GETDATE() - 30) 
GROUP BY WaitType
ORDER BY count DESC
END



GO
/****** Object:  StoredProcedure [dbo].[usp_InstDBInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_InstDBInfo]
(
@InstanceName varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Instance info
SELECT y.InstanceName, y.DBName, y.RecoveryModel, y.DBSizeInMB, 
CASE when y.LastBackupDate = '1/1/0001 12:00:00 AM' Then 'No Backup Taken Yet' else y.LastBackupDate End As FullBackup
FROM     (SELECT InstanceName, MAX(DateAdded) AS Rundate
                  FROM      [DB].[DatabaseInfo]
                  GROUP BY InstanceName) AS x INNER JOIN
                  [DB].[DatabaseInfo] AS y ON x.Rundate = y.DateAdded AND x.InstanceName = y.InstanceName AND y.InstanceName = @InstanceName

END



GO
/****** Object:  StoredProcedure [dbo].[usp_InstDBLogins]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[usp_InstDBLogins]
(
@InstanceName varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Instance DB Login Roles info
SELECT y.DBName, Y.DBUser, Y.DBRole
FROM     (SELECT InstanceName, MAX(DateAdded) AS Rundate
                  FROM      [DB].[DBUserRoles]
                  GROUP BY InstanceName) AS x INNER JOIN
                 [DB].[DBUserRoles] AS y ON x.Rundate = y.DateAdded AND x.InstanceName = y.InstanceName AND y.InstanceName =  @InstanceName

END



GO
/****** Object:  StoredProcedure [dbo].[usp_InstInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_InstInfo]
(
@InstanceName varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Instance info
SELECT y.ServerName, y.InstanceName, y.IPAddress, y.Port, y.SQLVersion, y.SQLPatchLevel, y.SQLEdition, y.SQLVersionNo, y.Collation, y.RootDirectory, 
                  y.DefaultDataPath, y.DefaultLogPath, y.ErrorLogPath, y.IsClustered, y.IsFullTextInstalled, y.IsSingleUser, y.IsAlwaysOnEnabled, y.TCPEnabled, 
                  y.NamedPipesEnabled, y.AlwaysOnStatus, y.MaxMemInMB, y.MinMemInMB, y.MaxDOP, y.NoOfUsrDBs, 
                  y.NoOfJobs, y.NoOfLnkSvrs, y.NoOfRoles, y.NoOfLogins, y.NoOfTriggers, y.NoOfAvailGrps, y.DateAdded
FROM     (SELECT InstanceName, MAX(DateAdded) AS Rundate
                  FROM      Inst.InstanceInfo
                  GROUP BY InstanceName) AS x INNER JOIN
                  Inst.InstanceInfo AS y ON x.Rundate = y.DateAdded AND x.InstanceName = y.InstanceName AND y.InstanceName = @InstanceName

END



GO
/****** Object:  StoredProcedure [dbo].[usp_InstJobs]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_InstJobs]
(
@InstanceName varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Instance Jobs info
    SELECT y.InstanceName, y.JobName, Y.IsEnabled, 
	CASE when Y.LastRunDate = '1/1/0001 12:00:00 AM' Then 'Never' else Y.LastRunDate End As LastRunDate, 
	y.LastRunOutcome, y.DateAdded
FROM     (SELECT InstanceName, MAX(DateAdded) AS Rundate
                  FROM      [Inst].[Jobs]
                  GROUP BY InstanceName) AS x INNER JOIN
                  [Inst].[Jobs] AS y ON x.Rundate = y.DateAdded AND x.InstanceName = y.InstanceName AND y.InstanceName = @InstanceName--'ME1-CVSQL1Q' and Y.LastRunDate <> '1/1/0001 12:00:00 AM'
END



GO
/****** Object:  StoredProcedure [dbo].[usp_InstLnkSvrs]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[usp_InstLnkSvrs]
(
@InstanceName varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Instance Linked Servers info
SELECT y.InstanceName, y.LinkedServerName,Y.ProviderName, Y.ProductName, Y.DateLastModified, Y.DataAccess, y.DateAdded
FROM     (SELECT InstanceName, MAX(DateAdded) AS Rundate
                  FROM      [Inst].[LinkedServers]
                  GROUP BY InstanceName) AS x INNER JOIN
                  [Inst].[LinkedServers] AS y ON x.Rundate = y.DateAdded AND x.InstanceName = y.InstanceName AND y.InstanceName = @InstanceName
END



GO
/****** Object:  StoredProcedure [dbo].[usp_InstLoginRoles]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_InstLoginRoles]
(
@InstanceName varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Instance Login Roles info
SELECT y.InstanceName, y.LoginName, Y.RoleName, Y.DateAdded
FROM     (SELECT InstanceName, MAX(DateAdded) AS Rundate
                  FROM      [Inst].[InstanceRoles]
                  GROUP BY InstanceName) AS x INNER JOIN
                  [Inst].[InstanceRoles] AS y ON x.Rundate = y.DateAdded AND x.InstanceName = y.InstanceName AND y.InstanceName =  @InstanceName

END



GO
/****** Object:  StoredProcedure [dbo].[usp_InstLogins]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[usp_InstLogins]
(
@InstanceName varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Instance Logins info
SELECT y.InstanceName, y.LoginName, y.LoginType, y.LoginCreateDate, y.LoginLastModified, y.IsDisabled, y.IsLocked, y.DateAdded
FROM     (SELECT InstanceName, MAX(DateAdded) AS Rundate
                  FROM      Inst.Logins
                  GROUP BY InstanceName) AS x INNER JOIN
                  Inst.Logins AS y ON x.Rundate = y.DateAdded AND x.InstanceName = y.InstanceName AND y.InstanceName = @InstanceName
END



GO
/****** Object:  StoredProcedure [dbo].[usp_InstMIIdx]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_InstMIIdx]
(
@InstanceName varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Missing Indexes info
    SELECT  y.InstanceName, Y.create_index_statement,y.improvement_measure, y.unique_compiles, y.user_seeks, y.avg_total_user_cost, y.avg_user_impact, y.DateAdded
FROM     (SELECT InstanceName, MAX(DateAdded) AS Rundate
                  FROM      [Inst].[MissingIndexes]
                  GROUP BY InstanceName) AS x INNER JOIN
                  [Inst].[MissingIndexes] AS y ON x.Rundate = y.DateAdded AND x.InstanceName = y.InstanceName AND y.InstanceName = @InstanceName


END



GO
/****** Object:  StoredProcedure [dbo].[usp_InstStats]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_InstStats]
(
@ServerName varchar(128),
@StartDate DateTime,
@EndDate DateTime
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Instance stats info
SELECT ServerName, RunDate, FwdRecSec, FlScansSec, IdxSrchsSec, PgSpltSec, FreeLstStallsSec, LzyWrtsSec, PgLifeExp, PgRdSec, PgWtSec, LogGrwths, TranSec, 
                  BlkProcs, UsrConns, LatchWtsSec, LckWtTime, LckWtsSec, DeadLockSec, MemGrnts, BatReqSec, SQLCompSec, SQLReCompSec
FROM     Inst.InsBaselineStats 
where ServerName =  @ServerName and (RunDate >= @StartDate) AND (RunDate <= @EndDate)

END

GO
/****** Object:  StoredProcedure [dbo].[usp_InstTriggers]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[usp_InstTriggers]
(
@InstanceName varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Instance Triggers info
SELECT y.InstanceName, y.TriggerName, y.CreateDate, y.LastModified, y.IsEnabled, y.DateAdded
FROM     (SELECT InstanceName, MAX(DateAdded) AS Rundate
                  FROM      [Inst].[InsTriggers]
                  GROUP BY InstanceName) AS x INNER JOIN
                  [Inst].[InsTriggers] AS y ON x.Rundate = y.DateAdded AND x.InstanceName = y.InstanceName AND y.InstanceName = @InstanceName
END



GO
/****** Object:  StoredProcedure [dbo].[usp_InstWaitStats]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[usp_InstWaitStats]
(
@InstanceName varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Instance Wait Stats info
SELECT y.InstanceName,y.WaitType, y.WaitCount, Y.Percentage,Y.AvgWait_S, Y.AvgRes_S, AvgSig_S, Y.DateAdded
FROM     (SELECT InstanceName, MAX(DateAdded) AS Rundate
                  FROM      [Inst].[WaitStats]
                  GROUP BY InstanceName) AS x INNER JOIN
                  [Inst].[WaitStats] AS y ON x.Rundate = y.DateAdded AND x.InstanceName = y.InstanceName AND y.InstanceName = @InstanceName
END



GO
/****** Object:  StoredProcedure [dbo].[usp_InvRpt]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[usp_InvRpt]
(
@Environment Varchar(128),
@OSName varchar(128),
@SQLVersion varchar(128),
@ASVersion varchar(128),
@RSVersion varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Inventory Report View
SELECT z.ServerName, v.Environment, w.IPAddress, z.OSName, z.OSUpTime, z.OSTotalVisibleMemorySizeInGB AS OSMemGB, w.NumberOfProcessors, w.NumberOfCores, 
                  w.IsHyperThreaded, w.CurrentCPUSpeed, w.IsVM, w.IsClu, v.InstanceName, S.SQLVersion, S.SQLEdition, S.SQLPatchLevel, S.IsSPUpToDate, A.ASVersion, A.ASEdition, 
                  A.ASPatchLevel, R.RSVersion, R.RSEdition, v.Description
FROM     (SELECT y.ServerName, y.OSName, y.OSLastRestart, y.OSUpTime, y.OSTotalVisibleMemorySizeInGB
                  FROM      (SELECT ServerName, MAX(DateAdded) AS Rundate
                                     FROM      Svr.OSInfo
                                     GROUP BY ServerName) AS x INNER JOIN
                                    Svr.OSInfo AS y ON x.Rundate = y.DateAdded AND x.ServerName = y.ServerName) AS z INNER JOIN
                      (SELECT y.ServerName, y.IPAddress, y.NumberOfProcessors, y.NumberOfLogicalProcessors, y.NumberOfCores, y.IsHyperThreaded, y.CurrentCPUSpeed, y.IsVM, 
                                         y.IsClu
                       FROM      (SELECT ServerName, MAX(DateAdded) AS Rundate
                                          FROM      Svr.ServerInfo
                                          GROUP BY ServerName) AS x_4 INNER JOIN
                                         Svr.ServerInfo AS y ON x_4.Rundate = y.DateAdded AND x_4.ServerName = y.ServerName) AS w ON z.ServerName = w.ServerName INNER JOIN
                      (SELECT DISTINCT ServerName, InstanceName, Environment, Description
                       FROM      Svr.ServerList) AS v ON z.ServerName = v.ServerName LEFT OUTER JOIN
                      (SELECT y.ServerName, y.SQLVersion, y.SQLPatchLevel, y.IsSPUpToDate, y.SQLEdition, y.SQLVersionNo
                       FROM      (SELECT ServerName, MAX(DateAdded) AS Rundate
                                          FROM      Inst.InstanceInfo
                                          GROUP BY ServerName) AS x_3 INNER JOIN
                                         Inst.InstanceInfo AS y ON x_3.Rundate = y.DateAdded AND x_3.ServerName = y.ServerName) AS S ON z.ServerName = S.ServerName LEFT OUTER JOIN
                      (SELECT y.ServerName, y.ASVersion, y.ASPatchLevel, y.IsSPUpToDateOnAS, y.ASEdition, y.ASVersionNo
                       FROM      (SELECT ServerName, MAX(DateAdded) AS Rundate
                                          FROM      [AS].SSASInfo
                                          GROUP BY ServerName) AS x_2 INNER JOIN
                                         [AS].SSASInfo AS y ON x_2.Rundate = y.DateAdded AND x_2.ServerName = y.ServerName) AS A ON z.ServerName = A.ServerName LEFT OUTER JOIN
                      (SELECT y.ServerName, y.RSVersion, y.RSEdition, y.RSVersionNo
                       FROM      (SELECT ServerName, MAX(DateAdded) AS Rundate
                                          FROM      RS.SSRSInfo
                                          GROUP BY ServerName) AS x_1 INNER JOIN
                                         RS.SSRSInfo AS y ON x_1.Rundate = y.DateAdded AND x_1.ServerName = y.ServerName) AS R ON z.ServerName = R.ServerName
Where V.Environment = @Environment and Z.OSName= @OSName and S.SQLVersion = @SQLVersion and A.ASVersion = @ASVersion and R.RsVersion= @RSVersion
END


GO
/****** Object:  StoredProcedure [dbo].[usp_InvView]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_InvView]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Inventory Report View
SELECT z.ServerName, v.Environment, w.IPAddress, z.OSName, z.OSUpTime, z.OSTotalVisibleMemorySizeInGB AS OSMemGB, w.NumberOfProcessors, w.NumberOfCores, 
                  w.IsHyperThreaded, w.CurrentCPUSpeed, w.IsVM, w.IsClu, v.InstanceName, S.SQLVersion, S.SQLEdition, S.SQLPatchLevel, S.IsSPUpToDate, s.IsClustered, A.ASVersion, A.ASEdition, 
                  A.ASPatchLevel, R.RSVersion, R.RSEdition, v.BusinessOwner, v.Description, V.Baseline, V.SQLPing
FROM     (SELECT y.ServerName, y.OSName, y.OSLastRestart, y.OSUpTime, y.OSTotalVisibleMemorySizeInGB
                  FROM      (SELECT ServerName, MAX(DateAdded) AS Rundate
                                     FROM      Svr.OSInfo
                                     GROUP BY ServerName) AS x INNER JOIN
                                    Svr.OSInfo AS y ON x.Rundate = y.DateAdded AND x.ServerName = y.ServerName) AS z INNER JOIN
                      (SELECT y.ServerName, y.IPAddress, y.NumberOfProcessors, y.NumberOfLogicalProcessors, y.NumberOfCores, y.IsHyperThreaded, y.CurrentCPUSpeed, y.IsVM, 
                                         y.IsClu
                       FROM      (SELECT ServerName, MAX(DateAdded) AS Rundate
                                          FROM      Svr.ServerInfo
                                          GROUP BY ServerName) AS x_4 INNER JOIN
                                         Svr.ServerInfo AS y ON x_4.Rundate = y.DateAdded AND x_4.ServerName = y.ServerName) AS w ON z.ServerName = w.ServerName INNER JOIN
                      (SELECT DISTINCT ServerName, InstanceName, Environment, Description, BusinessOwner, Baseline, SQLPing
                       FROM      Svr.ServerList) AS v ON z.ServerName = v.ServerName LEFT OUTER JOIN
                      (SELECT y.ServerName, y.SQLVersion, y.SQLPatchLevel, y.IsSPUpToDate, y.SQLEdition, y.SQLVersionNo, Y.IsClustered
                       FROM      (SELECT ServerName, MAX(DateAdded) AS Rundate
                                          FROM      Inst.InstanceInfo
                                          GROUP BY ServerName) AS x_3 INNER JOIN
                                         Inst.InstanceInfo AS y ON x_3.Rundate = y.DateAdded AND x_3.ServerName = y.ServerName) AS S ON z.ServerName = S.ServerName LEFT OUTER JOIN
                      (SELECT y.ServerName, y.ASVersion, y.ASPatchLevel, y.IsSPUpToDateOnAS, y.ASEdition, y.ASVersionNo
                       FROM      (SELECT ServerName, MAX(DateAdded) AS Rundate
                                          FROM      [AS].SSASInfo
                                          GROUP BY ServerName) AS x_2 INNER JOIN
                                         [AS].SSASInfo AS y ON x_2.Rundate = y.DateAdded AND x_2.ServerName = y.ServerName) AS A ON z.ServerName = A.ServerName LEFT OUTER JOIN
                      (SELECT y.ServerName, y.RSVersion, y.RSEdition, y.RSVersionNo
                       FROM      (SELECT ServerName, MAX(DateAdded) AS Rundate
                                          FROM      RS.SSRSInfo
                                          GROUP BY ServerName) AS x_1 INNER JOIN
                                         RS.SSRSInfo AS y ON x_1.Rundate = y.DateAdded AND x_1.ServerName = y.ServerName) AS R ON z.ServerName = R.ServerName
END


GO
/****** Object:  StoredProcedure [dbo].[usp_PgFlInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_PgFlInfo]
(
@servername varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Page File info
select  Y.PgFileLocation, y.PgAllocBaseSzInGB, y.pgcurrUsageInGB, Y.pgpeakusageInGB from(
select ServerName, Max(DateAdded) as Rundate 
from [Svr].[PgFileUsage]
Group BY Servername) x
Join [Svr].[PgFileUsage] y ON x.Rundate = y.DateAdded and X.ServerName = y.ServerName and y.ServerName = @servername

END



GO
/****** Object:  StoredProcedure [dbo].[usp_RSOverview]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_RSOverview]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Serverinfo View
Select z.InstanceName, z.RSVersion, z.RSEdition, z.IsSharePointIntegrated, v.Environment from (
select  y.* from(
select InstanceName, Max(DateAdded) as Rundate 
from [CentralDB].[RS].[SSRSInfo]
Group BY InstanceName) x
Join [CentralDB].[RS].[SSRSInfo] y ON x.Rundate = y.DateAdded and X.InstanceName = y.InstanceName) z
inner join(
select Distinct ServerName, InstanceName, Environment, Description, BusinessOwner from  [CentralDB].[Svr].[ServerList]) v ON Z.InstanceName = V.InstanceName
Order by InstanceName
END


GO
/****** Object:  StoredProcedure [dbo].[usp_SQLOverview]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_SQLOverview]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Serverinfo View
Select z.InstanceName, z.SQLVersion, z.SQLPatchLevel, z.IsSPUpToDate, z.SQLEdition, Z.NoOfUsrDBs, v.Environment from (
select  y.* from(
select InstanceName, Max(DateAdded) as Rundate 
from [CentralDB].[Inst].[InstanceInfo]
Group BY InstanceName) x
Join [CentralDB].[Inst].[InstanceInfo] y ON x.Rundate = y.DateAdded and X.InstanceName = y.InstanceName) z
inner join(
select Distinct ServerName, InstanceName, Environment, Description, BusinessOwner from  [CentralDB].[Svr].[ServerList]) v ON Z.InstanceName = V.InstanceName
Order by InstanceName
END


GO
/****** Object:  StoredProcedure [dbo].[usp_SQLSvcs]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[usp_SQLSvcs]
(
@servername varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--SQL Services info
select  y.DisplayName, Y.Started, Y.StartMode, Y.LogonAs, Y. ProcessId from(
select ServerName, Max(DateAdded) as Rundate 
from [Svr].[SQLServices]
Group BY Servername) x
Join [Svr].[SQLServices] y ON x.Rundate = y.DateAdded and X.ServerName = y.ServerName and y.ServerName =  @servername

END



GO
/****** Object:  StoredProcedure [dbo].[usp_SvrOverview]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_SvrOverview]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Serverinfo View
Select z.ServerName, z.OSName, w.NumberOfProcessors,  w.NumberOfCores, w.IsVM, w.IsClu, w.TotalPhysicalMemoryInGB--, v.Environment
				  from (
select  y.* from(
select ServerName, Max(DateAdded) as Rundate 
from [CentralDB].[Svr].[OSInfo]
Group BY Servername) x
Join [CentralDB].[Svr].[OSInfo] y ON x.Rundate = y.DateAdded and X.ServerName = y.ServerName) z
inner join (
select  y.* from(
select ServerName, Max(DateAdded) as Rundate 
from [CentralDB].[Svr].[ServerInfo]
Group BY Servername) x
Join [CentralDB].[Svr].[ServerInfo] y ON x.Rundate = y.DateAdded and X.ServerName = y.ServerName)w ON Z.ServerName = W.ServerName
--inner join(
--select Distinct ServerName, InstanceName, Environment, Description, BusinessOwner from  [CentralDB].[Svr].[ServerList]) v ON Z.ServerName = V.ServerName
END


GO
/****** Object:  StoredProcedure [dbo].[usp_SvrStats]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_SvrStats]
(
@ServerName varchar(128),
@StartDate DateTime,
@EndDate DateTime
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Instance stats info
SELECT ServerName,  RunDate, PctProcTm, ProcQLen, AvDskRd, AvDskWt, AvDskQLen, AvailMB, PgFlUsg
FROM     Svr.SvrBaselineStats
where ServerName =  @ServerName and (RunDate >= @StartDate) AND (RunDate <= @EndDate)

END



GO
/****** Object:  StoredProcedure [dbo].[usp_SysView]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_SysView]
(
@servername varchar(128)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Serverinfo View
Select z.ServerName, z.OSName, z.OSArchitecture, z.OSVersion, z.OSServicePack, z.OSInstallDate, z.OSLastRestart, z.OSUpTime, z.OSTotalVisibleMemorySizeInGB, 
                  z.OSFreePhysicalMemoryInGB, z.OSTotalVirtualMemorySizeInGB, z.OSFreeVirtualMemoryInGB, z.OSFreeSpaceInPagingFilesInGB, W.IPAddress, w.Model, w.Manufacturer, w.Description, 
                  w.SystemType, w.ActiveNodeName, w.Domain, w.DomainRole, w.PartOfDomain, w.NumberOfProcessors, w.NumberOfLogicalProcessors, w.NumberOfCores, 
                  w.IsHyperThreaded, w.CurrentCPUSpeed, w.MaxCPUSpeed, w.IsPowerSavingModeON, w.TotalPhysicalMemoryInGB, w.IsPagefileManagedBySystem, w.IsVM, w.IsClu, 
                  w.DateAdded--, v.Environment, v.Description, v.BusinessOwner, V.InstanceName
				  from (
select  y.* from(
select ServerName, Max(DateAdded) as Rundate 
from [CentralDB].[Svr].[OSInfo]
Group BY Servername) x
Join [CentralDB].[Svr].[OSInfo] y ON x.Rundate = y.DateAdded and X.ServerName = y.ServerName) z
inner join (
select  y.* from(
select ServerName, Max(DateAdded) as Rundate 
from [CentralDB].[Svr].[ServerInfo]
Group BY Servername) x
Join [CentralDB].[Svr].[ServerInfo] y ON x.Rundate = y.DateAdded and X.ServerName = y.ServerName)w ON Z.ServerName = W.ServerName and z.ServerName = @servername
--inner join(
--select Distinct ServerName, InstanceName, Environment, Description, BusinessOwner from  [CentralDB].[Svr].[ServerList]) v ON Z.ServerName = V.ServerName
END


GO
/****** Object:  StoredProcedure [dbo].[usp_WaitStats]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[usp_WaitStats]
(
@ServerName varchar(128),
@StartDate DateTime,
@EndDate DateTime
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--Instance stats info
SELECT DISTINCT WaitType, COUNT(WaitType) AS count
FROM     [Inst].[WaitStats]
where ServerName =  @ServerName and (DateAdded >= @StartDate) AND (DateAdded <= @EndDate)
GROUP BY WaitType
END



GO
/****** Object:  Table [AS].[SSASDBInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [AS].[SSASDBInfo](
	[ServerName] [nvarchar](128) NOT NULL,
	[InstanceName] [nvarchar](128) NULL,
	[DBName] [nvarchar](128) NULL,
	[DBSizeInMB] [decimal](10, 2) NULL,
	[Collation] [nvarchar](30) NULL,
	[CompatibilityLevel] [nvarchar](30) NULL,
	[DBCreateDate] [nvarchar](30) NULL,
	[DBLastProcessed] [nvarchar](30) NULL,
	[DBLastUpdated] [nvarchar](30) NULL,
	[DBStorageLocation] [nvarchar](500) NULL,
	[NoOfCubes] [smallint] NULL,
	[NoOfDimensions] [smallint] NULL,
	[ReadWriteMode] [nvarchar](30) NULL,
	[StorgageEngineUsed] [nvarchar](30) NULL,
	[IsVisible] [bit] NULL,
	[DateAdded] [smalldatetime] NULL,
	[ASDBID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [AS].[SSASInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [AS].[SSASInfo](
	[ServerName] [nvarchar](128) NOT NULL,
	[InstanceName] [nvarchar](128) NULL,
	[ProductName] [nvarchar](128) NULL,
	[ASVersion] [nvarchar](30) NULL,
	[ASPatchLevel] [nvarchar](10) NULL,
	[IsSPUpToDateOnAS] [bit] NULL,
	[ASEdition] [nvarchar](30) NULL,
	[ASVersionNo] [nvarchar](30) NULL,
	[NoOfDBs] [smallint] NULL,
	[LastSchemaUpdate] [nvarchar](30) NULL,
	[IsConnected] [bit] NULL,
	[IsMajorObjLoaded] [bit] NULL,
	[DateAdded] [smalldatetime] NULL,
	[ASID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [DB].[DatabaseFiles]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DB].[DatabaseFiles](
	[ServerName] [nvarchar](128) NULL,
	[InstanceName] [nvarchar](128) NULL,
	[DBName] [nvarchar](128) NOT NULL,
	[FileID] [int] NULL,
	[TypeDesc] [nvarchar](60) NULL,
	[LogicalName] [nvarchar](128) NULL,
	[PhysicalName] [nvarchar](260) NULL,
	[SizeInMB] [int] NULL,
	[GrowthPct] [int] NULL,
	[GrowthInMB] [int] NULL,
	[DateAdded] [smalldatetime] NULL,
	[DBFlID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [DB].[DatabaseInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DB].[DatabaseInfo](
	[ServerName] [nvarchar](128) NOT NULL,
	[InstanceName] [nvarchar](128) NOT NULL,
	[DBName] [nvarchar](128) NULL,
	[DBStatus] [nvarchar](20) NULL,
	[DBOwner] [nvarchar](128) NULL,
	[DBCreateDate] [smalldatetime] NULL,
	[DBSizeInMB] [decimal](10, 2) NULL,
	[DBSpaceAvailableInMB] [decimal](10, 2) NULL,
	[DBUsedSpaceInMB] [decimal](10, 2) NULL,
	[DBPctFreeSpace] [nvarchar](10) NULL,
	[DBDataSpaceUsageInMB] [decimal](10, 2) NULL,
	[DBIndexSpaceUsageInMB] [decimal](10, 2) NULL,
	[ActiveConnections] [int] NULL,
	[Collation] [nvarchar](30) NULL,
	[RecoveryModel] [nvarchar](10) NULL,
	[CompatibilityLevel] [nvarchar](30) NULL,
	[PrimaryFilePath] [nvarchar](256) NULL,
	[LastBackupDate] [nvarchar](128) NULL,
	[LastDifferentialBackupDate] [nvarchar](128) NULL,
	[LastLogBackupDate] [nvarchar](128) NULL,
	[AutoShrink] [bit] NULL,
	[AutoUpdateStatisticsEnabled] [bit] NULL,
	[IsReadCommittedSnapshotOn] [bit] NULL,
	[IsFullTextEnabled] [bit] NULL,
	[BrokerEnabled] [bit] NULL,
	[ReadOnly] [bit] NULL,
	[EncryptionEnabled] [bit] NULL,
	[IsDatabaseSnapshot] [bit] NULL,
	[ChangeTrackingEnabled] [bit] NULL,
	[IsMirroringEnabled] [bit] NULL,
	[MirroringPartnerInstance] [nvarchar](128) NULL,
	[MirroringStatus] [nvarchar](30) NULL,
	[MirroringSafetyLevel] [nvarchar](30) NULL,
	[ReplicationOptions] [nvarchar](30) NULL,
	[AvailabilityGroupName] [nvarchar](128) NULL,
	[NoOfTbls] [smallint] NULL,
	[NoOfViews] [smallint] NULL,
	[NoOfStoredProcs] [smallint] NULL,
	[NoOfUDFs] [smallint] NULL,
	[NoOfLogFiles] [tinyint] NULL,
	[NoOfFileGroups] [tinyint] NULL,
	[NoOfUsers] [smallint] NULL,
	[NoOfDBTriggers] [tinyint] NULL,
	[DateAdded] [smalldatetime] NULL,
	[DBID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [DB].[DBFileGrowth]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DB].[DBFileGrowth](
	[ServerName] [nvarchar](128) NULL,
	[InstanceName] [nvarchar](128) NULL,
	[DBName] [nvarchar](128) NULL,
	[DataFileInMB] [int] NULL,
	[LogFileInMB] [int] NULL,
	[DateAdded] [smalldatetime] NULL,
	[DBFGID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [DB].[DBUserRoles]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [DB].[DBUserRoles](
	[ServerName] [nvarchar](128) NULL,
	[InstanceName] [nvarchar](128) NULL,
	[DBName] [nvarchar](128) NULL,
	[DBUser] [nvarchar](128) NULL,
	[DBRole] [varchar](128) NULL,
	[DateAdded] [smalldatetime] NULL,
	[DBUsrID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [DB].[Triggers]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DB].[Triggers](
	[ServerName] [nvarchar](128) NULL,
	[InstanceName] [nvarchar](128) NULL,
	[DBName] [nvarchar](128) NULL,
	[TriggerName] [nvarchar](128) NULL,
	[CreateDate] [nvarchar](30) NULL,
	[LastModified] [nvarchar](30) NULL,
	[IsEnabled] [bit] NULL,
	[DateAdded] [smalldatetime] NULL,
	[DBTrgID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [Inst].[InsBaselineStats]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inst].[InsBaselineStats](
	[ServerName] [nvarchar](128) NULL,
	[InstanceName] [nvarchar](128) NULL,
	[FwdRecSec] [decimal](15, 0) NOT NULL,
	[FlScansSec] [decimal](15, 0) NOT NULL,
	[IdxSrchsSec] [decimal](15, 0) NOT NULL,
	[PgSpltSec] [decimal](15, 0) NOT NULL,
	[FreeLstStallsSec] [decimal](15, 0) NOT NULL,
	[LzyWrtsSec] [decimal](15, 0) NOT NULL,
	[PgLifeExp] [decimal](15, 0) NOT NULL,
	[PgRdSec] [decimal](15, 0) NOT NULL,
	[PgWtSec] [decimal](15, 0) NOT NULL,
	[LogGrwths] [decimal](15, 0) NOT NULL,
	[TranSec] [decimal](15, 0) NOT NULL,
	[BlkProcs] [decimal](15, 0) NOT NULL,
	[UsrConns] [decimal](15, 0) NOT NULL,
	[LatchWtsSec] [decimal](15, 0) NOT NULL,
	[LckWtTime] [decimal](15, 0) NOT NULL,
	[LckWtsSec] [decimal](15, 0) NOT NULL,
	[DeadLockSec] [decimal](15, 0) NOT NULL,
	[MemGrnts] [decimal](15, 0) NOT NULL,
	[BatReqSec] [decimal](15, 0) NOT NULL,
	[SQLCompSec] [decimal](15, 0) NOT NULL,
	[SQLReCompSec] [decimal](15, 0) NOT NULL,
	[RunDate] [smalldatetime] NOT NULL,
	[InsBLID] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [Inst].[InstanceInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inst].[InstanceInfo](
	[ServerName] [nvarchar](128) NOT NULL,
	[InstanceName] [nvarchar](128) NOT NULL,
	[IPAddress] [nvarchar](50) NULL,
	[Port] [nvarchar](30) NULL,
	[SQLVersion] [nvarchar](30) NULL,
	[SQLPatchLevel] [nvarchar](30) NULL,
	[IsSPUpToDate] [bit] NULL,
	[SQLEdition] [nvarchar](30) NULL,
	[SQLVersionNo] [nvarchar](50) NULL,
	[Collation] [nvarchar](50) NULL,
	[RootDirectory] [nvarchar](256) NULL,
	[DefaultDataPath] [nvarchar](256) NULL,
	[DefaultLogPath] [nvarchar](256) NULL,
	[ErrorLogPath] [nvarchar](256) NULL,
	[IsCaseSensitive] [bit] NULL,
	[IsClustered] [bit] NULL,
	[IsFullTextInstalled] [bit] NULL,
	[IsSingleUser] [bit] NULL,
	[IsAlwaysOnEnabled] [bit] NULL,
	[TCPEnabled] [bit] NULL,
	[NamedPipesEnabled] [bit] NULL,
	[ClusterName] [nvarchar](128) NULL,
	[ClusterQuorumState] [nvarchar](128) NULL,
	[ClusterQuorumType] [nvarchar](128) NULL,
	[AlwaysOnStatus] [nvarchar](50) NULL,
	[MaxMemInMB] [int] NULL,
	[MinMemInMB] [int] NULL,
	[MaxDOP] [tinyint] NULL,
	[NoOfUsrDBs] [smallint] NULL,
	[NoOfJobs] [smallint] NULL,
	[NoOfLnkSvrs] [smallint] NULL,
	[NoOfLogins] [smallint] NULL,
	[NoOfRoles] [tinyint] NULL,
	[NoOfTriggers] [tinyint] NULL,
	[NoOfAvailGrps] [tinyint] NULL,
	[DateAdded] [smalldatetime] NULL,
	[InstID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [Inst].[InstanceRoles]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inst].[InstanceRoles](
	[ServerName] [nvarchar](128) NULL,
	[InstanceName] [nvarchar](128) NULL,
	[LoginName] [nvarchar](128) NULL,
	[RoleName] [nvarchar](128) NULL,
	[DateAdded] [smalldatetime] NULL,
	[InstRID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [Inst].[InsTriggers]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inst].[InsTriggers](
	[ServerName] [nvarchar](128) NULL,
	[InstanceName] [nvarchar](128) NULL,
	[TriggerName] [nvarchar](128) NULL,
	[CreateDate] [nvarchar](30) NULL,
	[LastModified] [nvarchar](30) NULL,
	[IsEnabled] [bit] NULL,
	[DateAdded] [smalldatetime] NULL,
	[InsTrgID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [Inst].[Jobs]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inst].[Jobs](
	[ServerName] [nvarchar](128) NOT NULL,
	[InstanceName] [nvarchar](128) NOT NULL,
	[JobName] [nvarchar](128) NULL,
	[JobDescription] [nvarchar](max) NULL,
	[JobOwner] [nvarchar](128) NULL,
	[IsEnabled] [bit] NULL,
	[category] [nvarchar](128) NULL,
	[JobCreatedDate] [nvarchar](30) NULL,
	[JobLastModified] [nvarchar](30) NULL,
	[LastRunDate] [nvarchar](30) NULL,
	[NextRunDate] [nvarchar](30) NULL,
	[LastRunOutcome] [nvarchar](30) NULL,
	[CurrentRunRetryAttempt] [smallint] NULL,
	[OperatorToEmail] [nvarchar](128) NULL,
	[OperatorToPage] [nvarchar](128) NULL,
	[HasSchedule] [bit] NULL,
	[DateAdded] [smalldatetime] NULL,
	[JobID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [Inst].[LinkedServers]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inst].[LinkedServers](
	[ServerName] [nvarchar](128) NULL,
	[InstanceName] [nvarchar](128) NULL,
	[LinkedServerName] [nvarchar](128) NULL,
	[ProviderName] [nvarchar](30) NULL,
	[ProductName] [nvarchar](128) NULL,
	[ProviderString] [nvarchar](max) NULL,
	[DateLastModified] [nvarchar](30) NULL,
	[DataAccess] [bit] NULL,
	[DateAdded] [smalldatetime] NULL,
	[LnkID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [Inst].[Logins]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inst].[Logins](
	[ServerName] [nvarchar](128) NULL,
	[InstanceName] [nvarchar](128) NULL,
	[LoginName] [nvarchar](128) NULL,
	[LoginType] [nvarchar](20) NULL,
	[LoginCreateDate] [nvarchar](50) NULL,
	[LoginLastModified] [nvarchar](50) NULL,
	[IsDisabled] [bit] NULL,
	[IsLocked] [bit] NULL,
	[DateAdded] [smalldatetime] NULL,
	[LoginID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [Inst].[MissingIndexes]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inst].[MissingIndexes](
	[ServerName] [nvarchar](128) NULL,
	[InstanceName] [nvarchar](128) NULL,
	[DBName] [nvarchar](128) NULL,
	[SchemaName] [nvarchar](30) NULL,
	[MITable] [nvarchar](128) NULL,
	[improvement_measure] [nvarchar](30) NULL,
	[create_index_statement] [nvarchar](max) NULL,
	[group_handle] [int] NULL,
	[unique_compiles] [int] NULL,
	[user_seeks] [int] NULL,
	[last_user_seek] [smalldatetime] NULL,
	[avg_total_user_cost] [nvarchar](30) NULL,
	[avg_user_impact] [nvarchar](6) NULL,
	[DateAdded] [smalldatetime] NULL,
	[MIID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [Inst].[WaitStats]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Inst].[WaitStats](
	[ServerName] [nvarchar](128) NULL,
	[InstanceName] [nvarchar](128) NULL,
	[WaitType] [nvarchar](128) NULL,
	[Wait_S] [decimal](14, 2) NULL,
	[Resource_S] [decimal](14, 2) NULL,
	[Signal_S] [decimal](14, 2) NULL,
	[WaitCount] [bigint] NULL,
	[Percentage] [decimal](4, 2) NULL,
	[AvgWait_S] [decimal](14, 2) NULL,
	[AvgRes_S] [decimal](14, 2) NULL,
	[AvgSig_S] [decimal](14, 2) NULL,
	[DateAdded] [smalldatetime] NULL,
	[WtID] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [RS].[SSRSConfig]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RS].[SSRSConfig](
	[ServerName] [nvarchar](128) NOT NULL,
	[InstanceName] [nvarchar](128) NULL,
	[DatabaseServerName] [nvarchar](128) NULL,
	[IsDefaultInstance] [nvarchar](128) NULL,
	[PathName] [nvarchar](256) NULL,
	[DatabaseName] [nvarchar](128) NULL,
	[DatabaseLogonAccount] [nvarchar](128) NULL,
	[DatabaseLogonTimeout] [smallint] NULL,
	[DatabaseQueryTimeout] [smallint] NULL,
	[ConnectionPoolSize] [smallint] NULL,
	[IsInitialized] [bit] NULL,
	[IsReportManagerEnabled] [bit] NULL,
	[IsSharePointIntegrated] [bit] NULL,
	[IsWebServiceEnabled] [bit] NULL,
	[IsWindowsServiceEnabled] [bit] NULL,
	[SecureConnectionLevel] [smallint] NULL,
	[SendUsingSMTPServer] [bit] NULL,
	[SMTPServer] [nvarchar](128) NULL,
	[SenderEmailAddress] [nvarchar](128) NULL,
	[UnattendedExecutionAccount] [nvarchar](128) NULL,
	[ServiceName] [nvarchar](128) NULL,
	[WindowsServiceIdentityActual] [nvarchar](128) NULL,
	[DateAdded] [smalldatetime] NULL,
	[RSCID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [RS].[SSRSInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [RS].[SSRSInfo](
	[ServerName] [nvarchar](128) NOT NULL,
	[InstanceName] [nvarchar](128) NULL,
	[RSVersion] [nvarchar](30) NULL,
	[RSEdition] [nvarchar](128) NULL,
	[RSVersionNo] [nvarchar](30) NULL,
	[IsSharePointIntegrated] [bit] NULL,
	[DateAdded] [smalldatetime] NULL,
	[RSID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [Svr].[DiskInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Svr].[DiskInfo](
	[ServerName] [nvarchar](128) NOT NULL,
	[DiskName] [nvarchar](128) NULL,
	[Label] [nvarchar](128) NULL,
	[FileSystem] [nvarchar](30) NULL,
	[DskClusterSizeInKB] [int] NULL,
	[DskTotalSizeInGB] [decimal](10, 2) NULL,
	[DskFreeSpaceInGB] [decimal](10, 2) NULL,
	[DskUsedSpaceInGB] [decimal](10, 2) NULL,
	[DskPctFreeSpace] [nvarchar](10) NULL,
	[DateAdded] [smalldatetime] NULL,
	[DiskID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [Svr].[OSInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Svr].[OSInfo](
	[ServerName] [nvarchar](128) NOT NULL,
	[OSName] [nvarchar](128) NULL,
	[OSArchitecture] [nvarchar](30) NULL,
	[OSVersion] [nvarchar](20) NULL,
	[OSServicePack] [nvarchar](50) NULL,
	[OSInstallDate] [smalldatetime] NULL,
	[OSLastRestart] [smalldatetime] NULL,
	[OSUpTime] [nvarchar](128) NULL,
	[OSTotalVisibleMemorySizeInGB] [decimal](10, 2) NULL,
	[OSFreePhysicalMemoryInGB] [decimal](10, 2) NULL,
	[OSTotalVirtualMemorySizeInGB] [decimal](10, 2) NULL,
	[OSFreeVirtualMemoryInGB] [decimal](10, 2) NULL,
	[OSFreeSpaceInPagingFilesInGB] [decimal](10, 2) NULL,
	[DateAdded] [smalldatetime] NULL,
	[OSID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [Svr].[PgFileUsage]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Svr].[PgFileUsage](
	[ServerName] [nvarchar](128) NOT NULL,
	[PgFileLocation] [nvarchar](128) NULL,
	[PgAllocBaseSzInGB] [decimal](10, 2) NULL,
	[PgCurrUsageInGB] [decimal](10, 2) NULL,
	[PgPeakUsageInGB] [decimal](10, 2) NULL,
	[DateAdded] [smalldatetime] NULL,
	[PFID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [Svr].[ServerInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Svr].[ServerInfo](
	[ServerName] [nvarchar](128) NOT NULL,
	[IPAddress] [nvarchar](50) NULL,
	[Model] [nvarchar](128) NULL,
	[Manufacturer] [nvarchar](128) NULL,
	[Description] [nvarchar](128) NULL,
	[SystemType] [nvarchar](128) NULL,
	[ActiveNodeName] [nvarchar](128) NULL,
	[Domain] [nvarchar](128) NULL,
	[DomainRole] [nvarchar](128) NULL,
	[PartOfDomain] [bit] NULL,
	[NumberOfProcessors] [int] NULL,
	[NumberOfLogicalProcessors] [int] NULL,
	[NumberOfCores] [int] NULL,
	[IsHyperThreaded] [bit] NULL,
	[CurrentCPUSpeed] [int] NULL,
	[MaxCPUSpeed] [int] NULL,
	[IsPowerSavingModeON] [bit] NULL,
	[TotalPhysicalMemoryInGB] [decimal](10, 2) NULL,
	[IsPagefileManagedBySystem] [bit] NULL,
	[IsVM] [bit] NULL,
	[IsClu] [bit] NULL,
	[DateAdded] [smalldatetime] NULL,
	[SvrID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [Svr].[ServerList]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Svr].[ServerList](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [nvarchar](128) NOT NULL,
	[InstanceName] [nvarchar](128) NOT NULL,
	[Environment] [nvarchar](5) NULL,
	[Inventory] [bit] NOT NULL,
	[Baseline] [bit] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[BusinessOwner] [nvarchar](1000) NULL,
	[DateAdded] [smalldatetime] NULL,
	[SQLPing] [bit] NULL,
	[PingSnooze] [datetime2](7) NULL,
	[MaintStart] [datetime2](7) NULL,
	[MaintEnd] [datetime2](7) NULL,
 CONSTRAINT [IX_ServerList_InsName] UNIQUE NONCLUSTERED 
(
	[InstanceName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [Svr].[SQLServices]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Svr].[SQLServices](
	[ServerName] [nvarchar](128) NOT NULL,
	[ServiceName] [nvarchar](128) NULL,
	[DisplayName] [nvarchar](128) NULL,
	[Started] [bit] NULL,
	[StartMode] [nvarchar](30) NULL,
	[State] [nvarchar](30) NULL,
	[BinaryPath] [nvarchar](500) NULL,
	[LogOnAs] [nvarchar](128) NULL,
	[ProcessId] [int] NULL,
	[DateAdded] [smalldatetime] NULL,
	[SQLID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [Svr].[SvrBaselineStats]    Script Date: 4/7/2014 3:15:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Svr].[SvrBaselineStats](
	[ServerName] [nvarchar](128) NULL,
	[InstanceName] [nvarchar](128) NULL,
	[RunDate] [smalldatetime] NOT NULL,
	[PctProcTm] [decimal](10, 5) NOT NULL,
	[ProcQLen] [int] NOT NULL,
	[AvDskRd] [decimal](10, 5) NOT NULL,
	[AvDskWt] [decimal](10, 5) NOT NULL,
	[AvDskQLen] [decimal](10, 5) NOT NULL,
	[AvailMB] [bigint] NOT NULL,
	[PgFlUsg] [decimal](10, 5) NOT NULL,
	[SvrBLID] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_SSASDBInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_SSASDBInfo] ON [AS].[SSASDBInfo]
(
	[ServerName] ASC,
	[InstanceName] ASC,
	[DateAdded] ASC,
	[ASDBID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_SSASInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_SSASInfo] ON [AS].[SSASInfo]
(
	[ServerName] ASC,
	[InstanceName] ASC,
	[DateAdded] ASC,
	[ASID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_DatabaseFiles]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_DatabaseFiles] ON [DB].[DatabaseFiles]
(
	[ServerName] ASC,
	[InstanceName] ASC,
	[DBName] ASC,
	[DateAdded] ASC,
	[DBFlID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_DatabaseInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_DatabaseInfo] ON [DB].[DatabaseInfo]
(
	[InstanceName] ASC,
	[DBName] ASC,
	[DateAdded] ASC,
	[DBID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_DBFileGrowth]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_DBFileGrowth] ON [DB].[DBFileGrowth]
(
	[InstanceName] ASC,
	[DBName] ASC,
	[DateAdded] ASC,
	[DBFGID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_DBUserRoles]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_DBUserRoles] ON [DB].[DBUserRoles]
(
	[InstanceName] ASC,
	[DBName] ASC,
	[DateAdded] ASC,
	[DBUsrID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_DBTriggers]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_DBTriggers] ON [DB].[Triggers]
(
	[InstanceName] ASC,
	[DBName] ASC,
	[DateAdded] ASC,
	[DBTrgID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_InsBaselineStats]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_InsBaselineStats] ON [Inst].[InsBaselineStats]
(
	[ServerName] ASC,
	[InstanceName] ASC,
	[RunDate] ASC,
	[InsBLID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_InstanceInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_InstanceInfo] ON [Inst].[InstanceInfo]
(
	[ServerName] ASC,
	[InstanceName] ASC,
	[DateAdded] ASC,
	[InstID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_InstanceRoles]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_InstanceRoles] ON [Inst].[InstanceRoles]
(
	[ServerName] ASC,
	[InstanceName] ASC,
	[DateAdded] ASC,
	[InstRID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_InstTriggers]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_InstTriggers] ON [Inst].[InsTriggers]
(
	[ServerName] ASC,
	[InstanceName] ASC,
	[DateAdded] ASC,
	[InsTrgID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_Jobs]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_Jobs] ON [Inst].[Jobs]
(
	[ServerName] ASC,
	[InstanceName] ASC,
	[DateAdded] ASC,
	[JobID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_LinkedServers]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_LinkedServers] ON [Inst].[LinkedServers]
(
	[ServerName] ASC,
	[InstanceName] ASC,
	[DateAdded] ASC,
	[LnkID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_Logins]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_Logins] ON [Inst].[Logins]
(
	[ServerName] ASC,
	[InstanceName] ASC,
	[DateAdded] ASC,
	[LoginID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_MissingIndexes]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_MissingIndexes] ON [Inst].[MissingIndexes]
(
	[ServerName] ASC,
	[InstanceName] ASC,
	[DBName] ASC,
	[DateAdded] ASC,
	[MIID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_WaitStats]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_WaitStats] ON [Inst].[WaitStats]
(
	[ServerName] ASC,
	[InstanceName] ASC,
	[DateAdded] ASC,
	[WtID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_SSRSConfig]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_SSRSConfig] ON [RS].[SSRSConfig]
(
	[ServerName] ASC,
	[InstanceName] ASC,
	[DateAdded] ASC,
	[RSCID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_SSRSInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_SSRSInfo] ON [RS].[SSRSInfo]
(
	[ServerName] ASC,
	[InstanceName] ASC,
	[DateAdded] ASC,
	[RSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_DiskInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_DiskInfo] ON [Svr].[DiskInfo]
(
	[ServerName] ASC,
	[DateAdded] ASC,
	[DiskID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_OSInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_OSInfo] ON [Svr].[OSInfo]
(
	[ServerName] ASC,
	[DateAdded] ASC,
	[OSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_PgFileUsage]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_PgFileUsage] ON [Svr].[PgFileUsage]
(
	[ServerName] ASC,
	[DateAdded] ASC,
	[PFID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_ServerInfo]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_ServerInfo] ON [Svr].[ServerInfo]
(
	[ServerName] ASC,
	[DateAdded] ASC,
	[SvrID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_ServerList]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_ServerList] ON [Svr].[ServerList]
(
	[ServerName] ASC,
	[InstanceName] ASC,
	[DateAdded] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_SQLServices]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_SQLServices] ON [Svr].[SQLServices]
(
	[ServerName] ASC,
	[DateAdded] ASC,
	[SQLID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [CI_SvrBaselineStats]    Script Date: 4/7/2014 3:15:34 PM ******/
CREATE CLUSTERED INDEX [CI_SvrBaselineStats] ON [Svr].[SvrBaselineStats]
(
	[ServerName] ASC,
	[InstanceName] ASC,
	[RunDate] ASC,
	[SvrBLID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
GO
ALTER TABLE [Inst].[InsBaselineStats] ADD  CONSTRAINT [DF_InsStats_RunDate]  DEFAULT (getdate()) FOR [RunDate]
GO
ALTER TABLE [Svr].[ServerList] ADD  CONSTRAINT [DF_ServerList_DateAdded]  DEFAULT (getdate()) FOR [DateAdded]
GO
USE [master]
GO
ALTER DATABASE [CentralDB] SET  READ_WRITE 
GO

USE [msdb]
GO


/****** Object:  Job [CentralDB: Server Ping Status]    Script Date: 4/7/2014 3:33:06 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 4/7/2014 3:33:06 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'CentralDB: Server Ping Status', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'http:\\www.crazydba.com', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Ping all Servers in CentralDB]    Script Date: 4/7/2014 3:33:07 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Ping all Servers in CentralDB', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'PowerShell', 
		@command=N'C:\CentralDB\SQLPing.ps1', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every 5 Mins', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=5, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20140127, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

USE [msdb]
GO

/****** Object:  Job [CentralDB: SQL Server Inventory]    Script Date: 7/30/2013 4:37:28 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 7/30/2013 4:37:28 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'CentralDB: SQL Server Inventory', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'http:\\www.crazydba.com', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [SQL Server Inventory]    Script Date: 7/30/2013 4:37:28 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'SQL Server Inventory', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'PowerShell', 
		@command=N'C:\CentralDB\CentralInventory.ps1', 
		@output_file_name=N'C:\Temp\temp.txt', 
		@flags=2
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily Morning', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20130607, 
		@active_end_date=99991231, 
		@active_start_time=40000, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

USE [msdb]
GO

/****** Object:  Job [CentralDB: Baseline Stats]    Script Date: 7/30/2013 4:36:38 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 7/30/2013 4:36:38 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'CentralDB: Baseline Stats', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'http:\\www.crazydba.com', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Collect Baseline Stats]    Script Date: 7/30/2013 4:36:39 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Collect Baseline Stats', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'PowerShell', 
		@command=N'C:\CentralDB\BaselineStats.ps1', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Every 5 Mins', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=5, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20130607, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

USE [msdb]
GO

/****** Object:  Job [CentralDB: Wait Stats]    Script Date: 7/30/2013 4:37:44 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 7/30/2013 4:37:45 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'CentralDB: Wait Stats', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'http:\\www.crazydba.com', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Collect Wait Stats]    Script Date: 7/30/2013 4:37:45 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Collect Wait Stats', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'PowerShell', 
		@command=N'C:\CentralDB\WaitStats.ps1', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Weekly Once', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20130607, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

