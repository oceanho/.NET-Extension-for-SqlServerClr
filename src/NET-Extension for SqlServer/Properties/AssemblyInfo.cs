using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

// 有关程序集的常规信息通过以下
// 特性集控制。更改这些特性值可修改
// 与程序集关联的信息。
#if SQL2005
[assembly: AssemblyTitle("NET-Extension for SqlServer 2005")]
#elif SQL2008
[assembly: AssemblyTitle("NET-Extension for SqlServer 2008")]
#elif SQL2012
[assembly: AssemblyTitle("NET-Extension for SqlServer 2012")]
#elif SQL2014
[assembly: AssemblyTitle("NET-Extension for SqlServer 2014")]
#else
[assembly: AssemblyTitle("NET-Extension for SqlServer")]
#endif
[assembly: AssemblyDescription("NET-Extension for SqlServer")]
[assembly: AssemblyConfiguration("")]
[assembly: AssemblyCompany("OceanHo")]
[assembly: AssemblyProduct("NET-Extension for SqlServer")]
[assembly: AssemblyCopyright("Copyright © OceanHo 2015")]
[assembly: AssemblyTrademark("")]
[assembly: AssemblyCulture("")]

// 将 ComVisible 设置为 false 使此程序集中的类型
// 对 COM 组件不可见。  如果需要从 COM 访问此程序集中的类型，
// 则将该类型上的 ComVisible 特性设置为 true。
[assembly: ComVisible(false)]

// 如果此项目向 COM 公开，则下列 GUID 用于类型库的 ID
[assembly: Guid("8b9f45d9-5fc7-49de-b4dd-ee976d917da2")]

// 程序集的版本信息由下面四个值组成: 
//
//      主版本
//      次版本 
//      生成号
//      修订号
//
// 可以指定所有这些值，也可以使用“生成号”和“修订号”的默认值，
// 方法是按如下所示使用“*”: 
// [assembly: AssemblyVersion("1.0.*")]
[assembly: AssemblyVersion("15.11.13.105")]
[assembly: AssemblyFileVersion("15.11.13.105")]
