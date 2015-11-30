﻿using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
#if !SQL2005
using System.Linq;
#endif
#if !SQL2005 && !SQL2008
using System.Threading.Tasks;
#endif
using System.Text;
using SqlServerClrExtension.Utility;


namespace SqlServerClrExtension
{
    public static class SqlServerClrRegister
    {
        #region IsMatch
        [SqlFunction(DataAccess = DataAccessKind.None, SystemDataAccess = SystemDataAccessKind.None)]
        public static SqlBoolean IsMatch(SqlString input, SqlString pattern, SqlInt32 regexOption)
        {
            return SqlStringUtility.IsMatch(input, pattern, (System.Text.RegularExpressions.RegexOptions)regexOption.Value);
        }
        #endregion

        #region StartsWith,EndsWith

        [SqlFunction(DataAccess = DataAccessKind.None, SystemDataAccess = SystemDataAccessKind.None)]
        public static SqlBoolean StartsWith(SqlString src, SqlString des, SqlByte comparisonOption)
        {
            return SqlStringUtility.StartsWith(src, des, (StringComparison)comparisonOption.Value);
        }

        [SqlFunction(DataAccess = DataAccessKind.None, SystemDataAccess = SystemDataAccessKind.None)]
        public static SqlBoolean EndsWith(SqlString src, SqlString des, SqlByte comparisonOption)
        {
            return SqlStringUtility.EndsWith(src, des, (StringComparison)comparisonOption.Value);
        }
        #endregion

        #region DateFormator,GetPartTotalValue

        [SqlFunction(DataAccess = DataAccessKind.None, SystemDataAccess = SystemDataAccessKind.None)]
        public static SqlDouble GetPartTotalValue(SqlDateTime startDate, SqlDateTime finishDate, SqlString part)
        {
            return SqlStringUtility.GetPartTotalValue(startDate, finishDate, part);
        }

        [SqlFunction(DataAccess = DataAccessKind.None, SystemDataAccess = SystemDataAccessKind.None)]
        public static SqlDateTime DateFormator(SqlDateTime date, SqlString formator)
        {
            return SqlStringUtility.DateFormator(date, formator);
        }
        #endregion

        #region Trim,TrimStart,TrimEnd,TrimStartAndEnd

        [SqlFunction(DataAccess = DataAccessKind.None, SystemDataAccess = SystemDataAccessKind.None)]
        public static SqlString Trim(SqlString src, SqlChars des)
        {
            return SqlStringUtility.Trim(src, des);
        }

        [SqlFunction(DataAccess = DataAccessKind.None, SystemDataAccess = SystemDataAccessKind.None)]
        public static SqlString TrimStart(SqlString src, SqlChars des)
        {
            return SqlStringUtility.TrimStart(src, des);
        }

        [SqlFunction(DataAccess = DataAccessKind.None, SystemDataAccess = SystemDataAccessKind.None)]
        public static SqlString TrimEnd(SqlString src, SqlChars des)
        {
            return SqlStringUtility.TrimEnd(src, des);
        }

        [SqlFunction(DataAccess = DataAccessKind.None, SystemDataAccess = SystemDataAccessKind.None)]
        public static SqlString TrimStartAndEnd(SqlString src, SqlChars startDes, SqlChars endDes)
        {
            return SqlStringUtility.TrimStartAndEnd(src, startDes, endDes);
        }
        #endregion
    }
}
