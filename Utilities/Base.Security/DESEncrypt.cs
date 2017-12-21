//=====================================================================================
// All Rights Reserved , Copyright © Learun 2013
//=====================================================================================
using System;
using System.Collections.Generic;
using System.Text;
using System.Security.Cryptography;
using System.IO;
using System.Web.Security;

namespace LeaRun.Utilities
{
    /// <summary>
    /// 加密、解密帮助类
    /// 版本：2.0
    /// <author>
    ///		<name>shecixiong</name>
    ///		<date>2013.09.27</date>
    /// </author>
    /// </summary>
    public class DESEncrypt
    {
        #region ========加密========
        /// <summary>
        /// 加密
        /// </summary>
        /// <param name="Text"></param>
        /// <returns></returns>
        public static string Encrypt(string Text)
        {
            return Encrypt(Text, "adminqwe");
        }
        /// <summary> 
        /// 加密数据 
        /// </summary> 
        /// <param name="Text"></param> 
        /// <param name="sKey">密钥(8位字符)</param>
        /// <returns></returns> 
        /// 
        public static string Encrypt(string Text, string sKey)
        {
          

            using (DESCryptoServiceProvider des = new DESCryptoServiceProvider())
            {
                byte[] inputByteArray = Encoding.UTF8.GetBytes(Text);
                des.Key = ASCIIEncoding.ASCII.GetBytes(sKey);
                des.IV = ASCIIEncoding.ASCII.GetBytes(sKey);
                System.IO.MemoryStream ms = new System.IO.MemoryStream();
                using (CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(inputByteArray, 0, inputByteArray.Length);
                    cs.FlushFinalBlock();
                    cs.Close();
                }
                string str = Convert.ToBase64String(ms.ToArray());
                ms.Close();
                return str;
            }

        }
       
        #endregion

        #region ========解密========
        /// <summary>
        /// 解密
        /// </summary>
        /// <param name="sKey">密钥(8位字符)</param>
        /// <returns></returns>
        public static string Decrypt(string Text)
        {
            if (!string.IsNullOrEmpty(Text))
            {
                return Decrypt(Text, "adminqwe");
              
            }
            else
            {
                return "";
            }
        }
        /// <summary> 
        /// 解密数据 
        /// </summary> 
        /// <param name="Text"></param> 
        /// <param name="sKey"></param> 
        /// <returns></returns> 
        public static string Decrypt(string Text, string sKey)
        {
            byte[] inputByteArray = Convert.FromBase64String(Text);
            using (DESCryptoServiceProvider des = new DESCryptoServiceProvider())
            {
                des.Key = ASCIIEncoding.ASCII.GetBytes(sKey);
                des.IV = ASCIIEncoding.ASCII.GetBytes(sKey);
                MemoryStream ms = new MemoryStream();
                using (CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(inputByteArray, 0, inputByteArray.Length);
                    cs.FlushFinalBlock();
                    cs.Close();
                }
                string str = Encoding.UTF8.GetString(ms.ToArray());
                ms.Close();
                return str;
            }


        }
            #endregion
        }
}