


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
*	�ж� @src ���� @des �ַ�����ͷ��������������1�������㷵��0��ע�⣺��@src �� 
*	@des ��Ϊ NULL ������ 1��@src �� @des Ϊ NULL ������ 0
-------------------------------------------------------------------------------
	@src����Ҫ�жϵ�Դ�ַ�
	@des���жϵıȽ��ַ���
	@comparsionOption���Ƚ�ʹ�õ����򡢴�Сд�����������CSharp ö��
	StringComparison ����һ�£���ѡֵ���£�
	0��ʹ�����������������͵�ǰ����Ƚ��ַ�����
	1��ʹ����������������򡢵�ǰ�������Ƚ��ַ�����ͬʱ���Ա��Ƚ��ַ����Ĵ�Сд��
	2��ʹ�����������������͹̶�����Ƚ��ַ�����
	3��ʹ����������������򡢹̶��������Ƚ��ַ�����ͬʱ���Ա��Ƚ��ַ����Ĵ�Сд��
	4��ʹ������������Ƚ��ַ�����
	5��ʹ�����������򲢺��Ա��Ƚ��ַ����Ĵ�Сд�����ַ������бȽϡ�
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
*	�ж� @src ���� @des �ַ�����β��������������1�������㷵��0��ע�⣺��@src �� 
*	@des ��Ϊ NULL ������ 1��@src �� @des Ϊ NULL ������ 0
-------------------------------------------------------------------------------
	@src����Ҫ�жϵ�Դ�ַ�
	@des���жϵıȽ��ַ���
	@comparsionOption���Ƚ�ʹ�õ����򡢴�Сд�����������CSharp ö��
	StringComparison ����һ�£���ѡֵ���£�
	0��ʹ�����������������͵�ǰ����Ƚ��ַ�����
	1��ʹ����������������򡢵�ǰ�������Ƚ��ַ�����ͬʱ���Ա��Ƚ��ַ����Ĵ�Сд��
	2��ʹ�����������������͹̶�����Ƚ��ַ�����
	3��ʹ����������������򡢹̶��������Ƚ��ַ�����ͬʱ���Ա��Ƚ��ַ����Ĵ�Сд��
	4��ʹ������������Ƚ��ַ�����
	5��ʹ�����������򲢺��Ա��Ƚ��ַ����Ĵ�Сд�����ַ������бȽϡ�
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
*	ɾ�� @src �а����� @des �ַ���������ɾ��������ַ���ע�⣺��@src �� 
*	@des ��Ϊ NULL �� @src Ϊ NULL ���� NULL
-------------------------------------------------------------------------------
	@src����Ҫ����ɾ�������Դ�ַ�
	@des������ɾ��������ж��ַ���
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
*	ɾ�� @src �� @des ��ʼ�ַ���������ɾ��������ַ���ע�⣺��@src �� 
*	@des ��Ϊ NULL �� @src Ϊ NULL ���� NULL
-------------------------------------------------------------------------------
	@src����Ҫ����ɾ�������Դ�ַ�
	@des������ɾ��������ж��ַ���
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
*	ɾ�� @src �� @des ��β�ַ���������ɾ��������ַ���ע�⣺��@src �� 
*	@des ��Ϊ NULL �� @src Ϊ NULL ���� NULL
-------------------------------------------------------------------------------
	@src����Ҫ����ɾ�������Դ�ַ�
	@des������ɾ��������ж��ַ���
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
*	ɾ�� @src ��Ϊ @startDes��ͷ���� @endDes ��β�ַ���������ɾ��������ַ���
*	ע�⣺��@src �� @des ��Ϊ NULL ���� NULL
-------------------------------------------------------------------------------
	@src����Ҫ����ɾ�������Դ�ַ�
	@startDes����ʼƥ��ɾ��������ж��ַ���
	@endDes������ƥ��ɾ��������ж��ַ���
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
*	�ж� @input ������ @pattern ����ƥ�䡢������������1�������㷵��0��
*	ע�⣺��@input �� @pattern ��Ϊ NULL ������ 1
-------------------------------------------------------------------------------
	@input�������ַ���
	@pattern��������ʽ�ַ�
	@regexOption���ṩ��������������ʽѡ��
		�� System.Text.RegularExpressions.RegexOptions һ�£��˲���֧��λ���㡣
	��ѡֵ���£�
	0��ָ���������κ�ѡ�        
    1��ָ�������ִ�Сд��ƥ�䡣
	2������ģʽ�� ���� ^ �� $ �ĺ��壬ʹ���Ƿֱ�������һ�е����׺���βƥ�䣬���������������ַ����Ŀ�ͷ�ͽ�βƥ�䡣
    4��ָ��Ψһ��Ч�Ĳ�������ʽ�������ŵ� (?<name>��) ��ʽ���顣 ��ʹδ������Բ���ſ��Գ䵱�ǲ����飬���Ҳ���ʹ���ʽ���﷨ (?:...) �Եñ�׾��
	8��ָ����������ʽ����Ϊ���򼯡� �����������ִ���ٶȣ�������������ʱ�䡣 �ڵ��� System.Text.RegularExpressions.Regex.CompileToAssembly(System.Text.RegularExpressions.RegexCompilationInfo[],System.Reflection.AssemblyName)
       ����ʱ����Ӧ����ֵ����� System.Text.RegularExpressions.RegexCompilationInfo.Options ���ԡ�
	16��ָ������ģʽ�� ���ĵ� (.) �ĺ��壬��ʹ����ÿ���ַ��������ǳ� \n ֮��������ַ���ƥ�䡣
    32������ģʽ�еķ�ת��հײ������� # ��ǵ�ע�͡� ���ǣ�System.Text.RegularExpressions.RegexOptions.IgnorePatternWhitespace
		ֵ����Ӱ��������ַ����еĿհס�        
    64��ָ������������������Ǵ������ҽ��С�
	256��Ϊ���ʽ���÷��� ECMAScript ����Ϊ�� ��ֵֻ���� System.Text.RegularExpressions.RegexOptions.IgnoreCase��System.Text.RegularExpressions.RegexOptions.Multiline
       �� System.Text.RegularExpressions.RegexOptions.Compiled ֵһ��ʹ�á� ��ֵ�������κ�ֵһ��ʹ�þ��������쳣��
    512��ָ�����������е������Բ��졣 �йظ�����Ϣ����μ�������ʽѡ�

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



/*-- ��SqlClr���򼯵�SqlServer������չ --*/

IF EXISTS(SELECT TOP 1 * FROM sys.objects WHERE name=N'uf_trim' AND type='FN')
	DROP FUNCTION uf_trim
GO

-- ͬʱȥ�� �ո����Ʊ��Tab
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

SELECT dbo.uF_SqlClr_Trim(N'�κ� ',N'	') ---'�κ� '

SELECT dbo.uF_SqlClr_StartsWith(N'abcdef',N'��',3)
SELECT dbo.uF_SqlClr_EndsWith(N'abcdef',N'f',3)
SELECT LEN( dbo.uF_SqlClr_Trim(N'hehai ',N' ') )