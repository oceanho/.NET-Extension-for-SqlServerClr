


EXEC sys.sp_configure  'clr enabled',1
GO
RECONFIGURE; 
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


IF EXISTS(SELECT TOP 1 * FROM SYS.objects WHERE name=N'uF_SqlClr_StartsWith' AND [type]='FS')
	DROP FUNCTION [uF_SqlClr_StartsWith]
GO

IF EXISTS(SELECT TOP 1 * FROM SYS.objects WHERE name=N'uF_SqlClr_EndsWith' AND [type]='FS')
	DROP FUNCTION [uF_SqlClr_EndsWith]
GO

IF EXISTS(SELECT TOP 1 * FROM SYS.objects WHERE name=N'uF_SqlClr_Trim' AND [type]='FS')
	DROP FUNCTION [uF_SqlClr_Trim]
GO

IF EXISTS(SELECT TOP 1 * FROM SYS.objects WHERE name=N'uF_SqlClr_TrimStart' AND [type]='FS')
	DROP FUNCTION [uF_SqlClr_TrimStart]
GO

IF EXISTS(SELECT TOP 1 * FROM SYS.objects WHERE name=N'uF_SqlClr_TrimEnd' AND [type]='FS')
	DROP FUNCTION [uF_SqlClr_TrimEnd]
GO

IF EXISTS(SELECT TOP 1 * FROM SYS.objects WHERE name=N'uF_SqlClr_TrimStartAndEnd' AND [type]='FS')
	DROP FUNCTION [uF_SqlClr_TrimStartAndEnd]
GO

IF EXISTS(SELECT TOP 1 * FROM SYS.objects WHERE name=N'uF_SqlClr_IsMatch' AND [type]='FS')
	DROP FUNCTION [uF_SqlClr_IsMatch]
GO



IF EXISTS(SELECT TOP 1 * FROM SYS.assemblies WHERE name=N'SqlClrExtension')
	DROP ASSEMBLY [SqlClrExtension]
GO

DECLARE @SqlClrDLL_PATH NVARCHAR(1000)=N'E:\Microsoft SQL Server\100\SDK\Assemblies\users\SqlClrExtension.dll'
CREATE ASSEMBLY [SqlClrExtension]
FROM @SqlClrDLL_PATH
WITH PERMISSION_SET=SAFE
GO


/*
*
*	判断 @src 否以 @des 字符串开头、满足条件返回1，不满足返回0、注意：若@src 与 
*	@des 都为 NULL ，返回 1，@src 或 @des 为 NULL ，返回 0
-------------------------------------------------------------------------------
	@src：需要判断的源字符
	@des：判断的比较字符串
	@comparsionOption：比较使用的区域、大小写和排序规则，与CSharp 枚举
	StringComparison 保持一致，可选值如下；
	0：使用区域敏感排序规则和当前区域比较字符串。
	1：使用区域敏感排序规则、当前区域来比较字符串，同时忽略被比较字符串的大小写。
	2：使用区域敏感排序规则和固定区域比较字符串。
	3：使用区域敏感排序规则、固定区域来比较字符串，同时忽略被比较字符串的大小写。
	4：使用序号排序规则比较字符串。
	5：使用序号排序规则并忽略被比较字符串的大小写，对字符串进行比较。
-------------------------------------------------------------------------------*/
CREATE FUNCTION uF_SqlClr_StartsWith
(
	@src NVARCHAR(MAX),
	@des NVARCHAR(200)=N'',
	@comparsionOption TINYINT=3
)
RETURNS bit
AS
	EXTERNAL NAME [SqlClrExtension].[SqlServerClrExtension.SqlServerClrRegister].StartsWith
GO



/*
*
*	判断 @src 否以 @des 字符串结尾、满足条件返回1，不满足返回0、注意：若@src 与 
*	@des 都为 NULL ，返回 1，@src 或 @des 为 NULL ，返回 0
-------------------------------------------------------------------------------
	@src：需要判断的源字符
	@des：判断的比较字符串
	@comparsionOption：比较使用的区域、大小写和排序规则，与CSharp 枚举
	StringComparison 保持一致，可选值如下；
	0：使用区域敏感排序规则和当前区域比较字符串。
	1：使用区域敏感排序规则、当前区域来比较字符串，同时忽略被比较字符串的大小写。
	2：使用区域敏感排序规则和固定区域比较字符串。
	3：使用区域敏感排序规则、固定区域来比较字符串，同时忽略被比较字符串的大小写。
	4：使用序号排序规则比较字符串。
	5：使用序号排序规则并忽略被比较字符串的大小写，对字符串进行比较。
-------------------------------------------------------------------------------*/
CREATE FUNCTION uF_SqlClr_EndsWith
(
	@src NVARCHAR(MAX),
	@des NVARCHAR(200)=N'',
	@comparsionOption TINYINT=3
)
RETURNS bit
AS
	EXTERNAL NAME [SqlClrExtension].[SqlServerClrExtension.SqlServerClrRegister].EndsWith
GO


/*
*
*	删除 @src 中包含的 @des 字符，并返回删除后的新字符、注意：若@src 与 
*	@des 都为 NULL 或 @src 为 NULL 返回 NULL
-------------------------------------------------------------------------------
	@src：需要进行删除处理的源字符
	@des：进行删除处理的判断字符串
-------------------------------------------------------------------------------*/
CREATE FUNCTION uF_SqlClr_Trim
(
	@src NVARCHAR(MAX),
	@des NVARCHAR(200)=N' '
)
RETURNS NVARCHAR(MAX)
AS
	EXTERNAL NAME [SqlClrExtension].[SqlServerClrExtension.SqlServerClrRegister].Trim
GO

/*
*
*	删除 @src 以 @des 开始字符，并返回删除后的新字符、注意：若@src 与 
*	@des 都为 NULL 或 @src 为 NULL 返回 NULL
-------------------------------------------------------------------------------
	@src：需要进行删除处理的源字符
	@des：进行删除处理的判断字符串
-------------------------------------------------------------------------------*/
CREATE FUNCTION uF_SqlClr_TrimStart
(
	@src NVARCHAR(MAX),
	@des NVARCHAR(200)=N' '
)
RETURNS NVARCHAR(MAX)
AS
	EXTERNAL NAME [SqlClrExtension].[SqlServerClrExtension.SqlServerClrRegister].TrimStart
GO


/*
*
*	删除 @src 以 @des 结尾字符，并返回删除后的新字符、注意：若@src 与 
*	@des 都为 NULL 或 @src 为 NULL 返回 NULL
-------------------------------------------------------------------------------
	@src：需要进行删除处理的源字符
	@des：进行删除处理的判断字符串
-------------------------------------------------------------------------------*/
CREATE FUNCTION uF_SqlClr_TrimEnd
(
	@src NVARCHAR(MAX),
	@des NVARCHAR(200)=N' '
)
RETURNS NVARCHAR(MAX)
AS
	EXTERNAL NAME [SqlClrExtension].[SqlServerClrExtension.SqlServerClrRegister].TrimEnd
GO


/*
*
*	删除 @src 以为 @startDes开头和以 @endDes 结尾字符，并返回删除后的新字符、
*	注意：若@src 与 @des 都为 NULL 返回 NULL
-------------------------------------------------------------------------------
	@src：需要进行删除处理的源字符
	@startDes：开始匹配删除处理的判断字符串
	@endDes：结束匹配删除处理的判断字符串
-------------------------------------------------------------------------------*/
CREATE FUNCTION uF_SqlClr_TrimStartAndEnd
(
	@src NVARCHAR(MAX),
	@startDes NVARCHAR(200)=N' ',
	@endDes NVARCHAR(200)=N' '
)
RETURNS NVARCHAR(MAX)
AS
	EXTERNAL NAME [SqlClrExtension].[SqlServerClrExtension.SqlServerClrRegister].TrimStartAndEnd
GO




/*
*
*	判断 @input 否满足 @pattern 正则匹配、满足条件返回1，不满足返回0、
*	注意：若@input 与 @pattern 都为 NULL ，返回 1
-------------------------------------------------------------------------------
	@input：输入字符串
	@pattern：正则表达式字符
	@regexOption：提供用于设置正则表达式选项
		与 System.Text.RegularExpressions.RegexOptions 一致，此参数支持位运算。
	可选值如下；
	0：指定不设置任何选项。        
    1：指定不区分大小写的匹配。
	2：多行模式。 更改 ^ 和 $ 的含义，使它们分别在任意一行的行首和行尾匹配，而不仅仅在整个字符串的开头和结尾匹配。
    4：指定唯一有效的捕获是显式命名或编号的 (?<name>…) 形式的组。 这使未命名的圆括号可以充当非捕获组，并且不会使表达式的语法 (?:...) 显得笨拙。
	8：指定将正则表达式编译为程序集。 这会产生更快的执行速度，但会增加启动时间。 在调用 System.Text.RegularExpressions.Regex.CompileToAssembly(System.Text.RegularExpressions.RegexCompilationInfo[],System.Reflection.AssemblyName)
       方法时，不应将此值分配给 System.Text.RegularExpressions.RegexCompilationInfo.Options 属性。
	16：指定单行模式。 更改点 (.) 的含义，以使它与每个字符（而不是除 \n 之外的所有字符）匹配。
    32：消除模式中的非转义空白并启用由 # 标记的注释。 但是，System.Text.RegularExpressions.RegexOptions.IgnorePatternWhitespace
		值不会影响或消除字符类中的空白。        
    64：指定搜索从右向左而不是从左向右进行。
	256：为表达式启用符合 ECMAScript 的行为。 该值只能与 System.Text.RegularExpressions.RegexOptions.IgnoreCase、System.Text.RegularExpressions.RegexOptions.Multiline
       和 System.Text.RegularExpressions.RegexOptions.Compiled 值一起使用。 该值与其他任何值一起使用均将导致异常。
    512：指定忽略语言中的区域性差异。 有关更多信息，请参见正则表达式选项。

	select 1 | 2 | 4 | 8 | 16 | 32 | 64 | 256 | 512
-------------------------------------------------------------------------------*/
CREATE FUNCTION uF_SqlClr_IsMatch
(
	@input NVARCHAR(MAX),
	@pattern NVARCHAR(200)=N'',
	@regexOption INT=895
)
RETURNS bit
AS
	EXTERNAL NAME [SqlClrExtension].[SqlServerClrExtension.SqlServerClrRegister].IsMatch
GO



/*-- 对SqlClr程序集的SqlServer函数扩展 --*/

IF EXISTS(SELECT TOP 1 * FROM sys.objects WHERE name=N'uf_trim' AND type='FN')
	DROP FUNCTION uf_trim
GO

-- 同时去除 空格与制表符Tab
CREATE FUNCTION uf_trim(
	@src NVARCHAR(MAX)
) RETURNS NVARCHAR(MAX) AS
BEGIN
	RETURN dbo.uF_SqlClr_Trim(dbo.uF_SqlClr_Trim(@src,N' '),N'	')
END
GO

SELECT dbo.uf_trim(N'')
SELECT ''
SELECT dbo.uf_trim(' 1                               ')

SELECT dbo.uF_SqlClr_Trim(N'何海 ',N'	') ---'何海 '

SELECT dbo.uF_SqlClr_StartsWith(N'abcdef',N'何',3)
SELECT dbo.uF_SqlClr_EndsWith(N'abcdef',N'f',3)
SELECT LEN( dbo.uF_SqlClr_Trim(N'hehai ',N' ') )