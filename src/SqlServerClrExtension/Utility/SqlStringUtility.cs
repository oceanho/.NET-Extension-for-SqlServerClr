/***************************************************************
*       
* add by hehai 2015/11/13 18:02:03
*
****************************************************************/

using Microsoft.SqlServer.Server;
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
using System.Text.RegularExpressions;

namespace SqlServerClrExtension.Utility
{
    internal static class SqlStringUtility
    {
        #region SqlString SqlClr Methods
        internal static SqlBoolean StartsWith(SqlString src, SqlString des, StringComparison comparisonOption)
        {
            if (IsAllNull(src, des))
                return SqlBoolean.True;

            if (IsAnyNull(src, des))
                return SqlBoolean.False;
            return src.Value.Equals(des.Value, comparisonOption) ? SqlBoolean.True :
            src.Value.StartsWith(des.Value, comparisonOption);
        }

        internal static SqlBoolean EndsWith(SqlString src, SqlString des, StringComparison comparisonOption)
        {
            if (IsAllNull(src, des))
                return SqlBoolean.True;

            if (IsAnyNull(src, des))
                return SqlBoolean.False;
            return src.Value.Equals(des.Value, comparisonOption) ? SqlBoolean.True :
            src.Value.EndsWith(des.Value, comparisonOption);
        }

        internal static SqlString Trim(SqlString src, SqlChars des)
        {
            if (IsAllNull(des)) return src;
            if (IsAllNull(src)) return SqlString.Null;
            string _s = src.Value;
            return new SqlString(_s.Trim(des.Value));
        }
        internal static SqlString TrimStart(SqlString src, SqlChars des)
        {
            if (IsAllNull(des)) return src;
            if (IsAllNull(src)) return SqlString.Null;
            string _s = src.Value;
            return new SqlString(_s.TrimStart(des.Value));
        }

        internal static SqlString TrimEnd(SqlString src, SqlChars des)
        {
            if (IsAllNull(des)) return src;
            if (IsAllNull(src)) return SqlString.Null;
            string _s = src.Value;
            return new SqlString(_s.TrimEnd(des.Value));
        }

        internal static SqlString TrimStartAndEnd(SqlString src, SqlChars des)
        {
            return TrimStartAndEnd(src, des, des);
        }
        internal static SqlString TrimStartAndEnd(SqlString src, SqlChars startDes, SqlChars endDes)
        {
            if (IsAllNull(startDes, endDes)) return src;
            if (IsAllNull(src)) return SqlString.Null;
            string _s = src.Value;
            if (!endDes.IsNull) _s = _s.TrimEnd(endDes.Value);
            if (!startDes.IsNull) _s = _s.TrimStart(startDes.Value);
            return new SqlString(_s);
        }
        #endregion

        #region SqlString Date

        internal static SqlDouble GetPartTotalValue(SqlDateTime startDate, SqlDateTime finishDate, SqlString part)
        {
            SqlDouble @return = SqlDouble.Zero;
            if (IsAnyNull(part)) return @return;
            if (IsAnyNull(startDate)) return @return;
            if (IsAnyNull(finishDate)) return @return;
            if (finishDate.Value < startDate.Value) return  @return;

            if (part.Value.Equals("TotalDays", StringComparison.OrdinalIgnoreCase)) @return = new SqlDouble((finishDate.Value - startDate.Value).TotalDays);
            if (part.Value.Equals("TotalHours", StringComparison.OrdinalIgnoreCase)) @return = new SqlDouble((finishDate.Value - startDate.Value).TotalHours);
            if (part.Value.Equals("TotalMinutes", StringComparison.OrdinalIgnoreCase)) @return = new SqlDouble((finishDate.Value - startDate.Value).TotalMinutes);
            if (part.Value.Equals("TotalSeconds", StringComparison.OrdinalIgnoreCase)) @return = new SqlDouble((finishDate.Value - startDate.Value).TotalSeconds);
            if (part.Value.Equals("TotalMilliseconds", StringComparison.OrdinalIgnoreCase)) @return = new SqlDouble((finishDate.Value - startDate.Value).TotalMilliseconds);
            return @return;
        }
        #endregion

        #region SqlString Base64 SqlClr Methods
        internal static SqlString Base64Encode(SqlString input)
        {
            if (IsAllNull(input))
                return SqlString.Null;
            byte[] array = Encoding.UTF8.GetBytes(input.Value);
            string result = Convert.ToBase64String(array);
            return new SqlString(result);
        }
        internal static SqlString Base64Decode(SqlString input)
        {
            if (IsAllNull(input))
                return SqlString.Null;
            byte[] array = System.Convert.FromBase64String(input.Value);
            string result = Encoding.UTF8.GetString(array);
            return new SqlString(result);
        }
        #endregion

        #region SqlString RegularExpression SqlClr Methods
        internal static SqlBoolean IsMatch(SqlString input, SqlString pattern, RegexOptions regexOption)
        {
            if (IsAllNull(input, pattern))
                return SqlBoolean.True;

            if (IsAnyNull(input, pattern))
                return SqlBoolean.False;
            return input.Value.Equals(pattern.Value, StringComparison.CurrentCultureIgnoreCase) ? SqlBoolean.True :
                Regex.IsMatch(input.Value, pattern.Value, regexOption);

            // RegexOptions.Compiled | RegexOptions.IgnoreCase | RegexOptions.Singleline
        }
        #endregion

        #region Private Methods

        private static bool IsAllNull(params INullable[] argument)
        {
            if (argument != null)
            {
                foreach (var item in argument)
                    if (!item.IsNull) return false;
            }
            return true;
        }
        private static bool IsAnyNull(params INullable[] argument)
        {
            if (argument != null)
            {
                foreach (var item in argument)
                    if (item.IsNull) return true;
            }
            return false;
        }
        #endregion
    }
}
