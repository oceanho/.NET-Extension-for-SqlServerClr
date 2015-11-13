


EXEC sys.sp_configure  'clr enabled',1
GO
RECONFIGURE; 
GO

DECLARE @SqlClrDLL_PATH NVARCHAR(1000)=N'E:\workroot\code-version-root\Tidebuy.Tests\NET-Extension for SqlServer 2008\bin\Release\NET-Extension for SqlServer.dll'

/****** Object:  SqlAssembly [NET-Extension for SqlServer]    Script Date: 2015/11/13 15:38:29 ******/
IF EXISTS(SELECT TOP 1 * FROM SYS.assemblies WHERE name=N'NET-Extension for SqlServer')
	DROP ASSEMBLY [NET-Extension for SqlServer]
GO

CREATE ASSEMBLY [NET-Extension for SqlServer]
FROM @SqlClrDLL_PATH
WITH PERMISSION_SET=SAFE

IF EXISTS(SELECT TOP 1 * FROM SYS.objects WHERE name=N'uF_SqlClr_StartsWith')
	DROP FUNCTION [uF_SqlClr_StartsWith]
GO
IF EXISTS(SELECT TOP 1 * FROM SYS.objects WHERE name=N'uF_SqlClr_EndsWith')
	DROP FUNCTION [uF_SqlClr_EndsWith]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION uF_SqlClr_StartsWith
(
	@soure NVARCHAR(MAX),
	@comparsion NVARCHAR(20)=NULL
)
RETURNS bit
AS
	EXTERNAL NAME [NET-Extension for SqlServer].[NET_Extension_for_SqlServer.SqlServerFunctionRegister].StartsWith
GO


SELECT dbo.uF_StartsWith(null,NULL)