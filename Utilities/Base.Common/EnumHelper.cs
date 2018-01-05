using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace Utilities.Base.Common
{
   public static  class EnumHelper
    {
        public static string GetEnumDescription(this Enum enumValue)
        {
            string str = enumValue.ToString();
            System.Reflection.FieldInfo field = enumValue.GetType().GetField(str);
            object[] objs = field.GetCustomAttributes(typeof(System.ComponentModel.DescriptionAttribute), false);
            if (objs.Length == 0) return str;
            var da = (System.ComponentModel.DescriptionAttribute)objs[0];
            return da.Description;
        }

       public static IList<SelectListItem>  GetSelectListItemByEnum(this Enum enumValue, SelectListItemSelect select )
        {
            NameValueCollection list = GetNVCFromEnumValue(enumValue.GetType());
            List<SelectListItem> listitem = new List<SelectListItem>();
            if (SelectListItemSelect.Ok == select)
            {
                listitem.Add(new SelectListItem { Text = "请选择", Value = "",Selected=true });
            }
         
            foreach (string key in list.Keys)
            {
               var  values = list.GetValues(key);
                foreach (string value in values)
                {
                   listitem.Add(new SelectListItem { Text = value, Value = key});
                }
            }
            return listitem;
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


        public static string GetEnumDesc(Type enumType, object val)
        {
            string enumvalue = System.Enum.GetName(enumType, val);
            if (string.IsNullOrEmpty(enumvalue))
            {
                return "";
            }
            System.Reflection.FieldInfo finfo = enumType.GetField(enumvalue);
            object[] enumAttr = finfo.GetCustomAttributes(typeof(System.ComponentModel.DescriptionAttribute), true);
            if (enumAttr.Length > 0)
            {
                System.ComponentModel.DescriptionAttribute desc = enumAttr[0] as System.ComponentModel.DescriptionAttribute;
                if (desc != null)
                {
                    return desc.Description;
                }
            }
            return enumvalue;
        }

        ///<summary>
        /// 根据值返回枚举对应的内容
        /// 创建人：Porschev
        /// 创建时间：2011-7-19
        ///</summary>
        ///<typeparam name="T">枚举</typeparam>
        ///<param name="value">值(int)</param>
        ///<returns></returns>
        public static T GetModel<T>(int value)
        {
            T myEnum = (T)System.Enum.Parse(typeof(T), value.ToString(), true);
            return myEnum;
        }
       
        ///<summary>
        /// 根据值返回枚举对应的内容
        /// 创建人：Porschev
        /// 创建时间：2011-7-19
        ///</summary>
        ///<typeparam name="T">枚举</typeparam>
        ///<param name="value">值(string)</param>
        ///<returns></returns>
        public static T GetModel<T>(string value)
        {
            T myEnum = (T)System.Enum.Parse(typeof(T), value, true);
            return myEnum;
        }
    }
}
