using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Utilities
{
  public static  class EnumToItemList
    {
        public static List<SelectListItem> ToSelectListItem(this Enum valueEnum)
        {
            return (from Enum value in Enum.GetValues(valueEnum.GetType())
                    select new SelectListItem
                    {
                        Text = value.GetEnumDescription(),
                        Value = value.GetHashCode().ToString()
                    }).ToList();
        }

        public static List<SelectListItem> ToSelectListItemByEnum(this Enum valueEnum)
        {
            return (from Enum value in Enum.GetValues(valueEnum.GetType())
                    select new SelectListItem
                    {
                        Text = value.ToString(),
                        Value = value.GetHashCode().ToString()
                    }).ToList();
        }

        /// <summary>
        /// Enum转SelectList
        /// </summary>
        /// <param name="valueEnum"></param>
        /// <param name="selectString">选中值</param>
        /// <param name="spiltString"></param>
        /// <returns></returns>
        public static List<SelectListItem> ToSelectListItem(this Enum valueEnum, string selectString, char spiltString = ',')
        {
            var list = new List<string>();
            if (!string.IsNullOrEmpty(selectString))
            {
                list.AddRange(selectString.Split(spiltString));
            }
            return (from Enum value in Enum.GetValues(valueEnum.GetType())
                    select new SelectListItem
                    {
                        Text = value.GetEnumDescription(),
                        Value = value.GetHashCode().ToString(),
                        Selected = list.Contains(value.GetHashCode().ToString())
                    }).ToList();
        }

        public static List<SelectListItem> ToSelectListItem(this Enum valueEnum, Enum defaultValue)
        {
            return (from Enum value in Enum.GetValues(valueEnum.GetType())
                    select new SelectListItem
                    {
                        Text = value.GetEnumDescription(),
                        Value = value.GetHashCode().ToString(),
                        Selected = value.Equals(defaultValue)
                    }).ToList();
        }
        public static int GetEnumValue(Type enumType, string enumName)
        {
            try
            {
                if (!enumType.IsEnum)
                    throw new ArgumentException("enumType必须是枚举类型");
                var values = Enum.GetValues(enumType);
                var ht = new Hashtable();
                foreach (var val in values)
                {
                    ht.Add(Enum.GetName(enumType, val), val);
                }
                return (int)ht[enumName];
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        public static string GetEnumDescription(this Enum enumValue)
        {
            string str = enumValue.ToString();
            System.Reflection.FieldInfo field = enumValue.GetType().GetField(str);
            object[] objs = field.GetCustomAttributes(typeof(System.ComponentModel.DescriptionAttribute), false);
            if (objs.Length == 0) return str;
            var da = (System.ComponentModel.DescriptionAttribute)objs[0];
            return da.Description;
        }
        public static string GetEnumDescription(string ob, Type enumType)
        {
            string str = ob;
            System.Reflection.FieldInfo field = enumType.GetField(str);
            object[] objs = field.GetCustomAttributes(typeof(System.ComponentModel.DescriptionAttribute), false);
            if (objs.Length == 0) return str;
            var da = (System.ComponentModel.DescriptionAttribute)objs[0];
            return da.Description;
        }

        /// <summary>  
        /// 扩展方法：根据枚举值得到相应的枚举定义字符串  
        /// </summary>  
        /// <param name="value"></param>  
        /// <param name="enumType"></param>  
        /// <returns></returns>  
        public static String ToEnumString(this int value, Type enumType)
        {
            NameValueCollection nvc = GetEnumStringFromEnumValue(enumType);
            return nvc[value.ToString()];
        }

        /// <summary>  
        /// 根据枚举类型得到其所有的 值 与 枚举定义字符串 的集合  
        /// </summary>  
        /// <param name="enumType"></param>  
        /// <returns></returns>  
        public static NameValueCollection GetEnumStringFromEnumValue(Type enumType)
        {
            NameValueCollection nvc = new NameValueCollection();
            Type typeDescription = typeof(DescriptionAttribute);
            System.Reflection.FieldInfo[] fields = enumType.GetFields();
            string strText = string.Empty;
            string strValue = string.Empty;
            foreach (FieldInfo field in fields)
            {
                if (field.FieldType.IsEnum)
                {
                    strValue = ((int)enumType.InvokeMember(field.Name, BindingFlags.GetField, null, null, null)).ToString();
                    nvc.Add(strValue, field.Name);
                }
            }
            return nvc;
        }

        /// <summary>  
        /// 扩展方法：根据枚举值得到属性Description中的描述, 如果没有定义此属性则返回空串  
        /// </summary>  
        /// <param name="value"></param>  
        /// <param name="enumType"></param>  
        /// <returns></returns>  
        public static String ToEnumDescriptionString(this int value, Type enumType)
        {
            NameValueCollection nvc = GetNVCFromEnumValue(enumType);
            return nvc[value.ToString()];
        }

        /// <summary>  
        /// 根据枚举类型得到其所有的 值 与 枚举定义Description属性 的集合  
        /// </summary>  
        /// <param name="enumType"></param>  
        /// <returns></returns>  
        public static NameValueCollection GetNVCFromEnumValue(Type enumType)
        {
            NameValueCollection nvc = new NameValueCollection();
            Type typeDescription = typeof(DescriptionAttribute);
            System.Reflection.FieldInfo[] fields = enumType.GetFields();
            string strText = string.Empty;
            string strValue = string.Empty;
            foreach (FieldInfo field in fields)
            {
                if (field.FieldType.IsEnum)
                {
                    strValue = ((int)enumType.InvokeMember(field.Name, BindingFlags.GetField, null, null, null)).ToString();
                    object[] arr = field.GetCustomAttributes(typeDescription, true);
                    if (arr.Length > 0)
                    {
                        DescriptionAttribute aa = (DescriptionAttribute)arr[0];
                        strText = aa.Description;
                    }
                    else
                    {
                        strText = "";
                    }
                    nvc.Add(strValue, strText);
                }
            }
            return nvc;
        }

        /// <summary>
        /// 通过文件名字得到后缀名
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static string GetFileSuffix(this string str)
        {
            var index = str.LastIndexOf(".");
            var result = str.Substring(index);
            return result;

        }
      
              
           
    }
}
