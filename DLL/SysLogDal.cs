using LeaRun.Utilities;
using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using Utilities;

namespace DAL
{
    public  class SysLogDal: RepositoryFactory<SysLog>
    {

        private static SysLogDal _instance;
        private static object _object = new Object();
        public static SysLogDal GetInstance()
        {
            if (_instance == null)
            {
                lock (_object)
                {
                    if (_instance == null)
                    {
                        _instance = new SysLogDal();
                    }
                }
            }
            return _instance;
        }
        private SysLogDal()
        {

        }
        public SysLog SysLog = new SysLog();
        //写入日志
        public void WriteLog(string  objectId, OperationType operationType,LogSatus logSatus , string remark = "")
       {
            SysLog.ObjectId = objectId;
            SysLog.LogType = (int)logSatus;
            if (ManageProvider.Provider.IsOverdue())
            {
                SysLog.IPAddress = ManageProvider.Provider.Current().IPAddress;
                SysLog.IPAddressName = ManageProvider.Provider.Current().IPAddressName;
                SysLog.CreateUserId = ManageProvider.Provider.Current().UserId;
                SysLog.CreateUserName = ManageProvider.Provider.Current().Account;
            }
            if (CookieHelper.GetCookie("ModuleId") != "")
            {
                SysLog.ModuleId = int.Parse(DESEncrypt.Decrypt(CookieHelper.GetCookie("ModuleId")));
            }
            SysLog.CreateTime = DateTime.Now;
            SysLog.Remark = remark;
            SysLog.Status = (int)logSatus;
            var task = Task.Factory.StartNew(() =>
            {
                Repository().Insert(SysLog);
            });

        }

        /// <summary>
        /// 写入作业日志（新增操作）
        /// </summary>
        /// <param name="entity">实体对象</param>
        /// <param name="OperationType">操作类型</param>
        /// <param name="Status">状态</param>
        /// <param name="Remark">操作说明</param>
        /// <returns></returns>
        public void WriteLog<T>(T entity, OperationType OperationType, int Status, string Remark = "")
        {
            IDatabase database = DataFactory.Database();
            DbTransaction isOpenTrans = database.BeginTrans();
            try
            {
           
                SysLog.ObjectId = DatabaseCommon.GetKeyFieldValue(entity).ToString();
                SysLog.LogType = (int)OperationType;
                SysLog.IPAddress = ManageProvider.Provider.Current().IPAddress;
                SysLog.IPAddressName = ManageProvider.Provider.Current().IPAddressName;
                SysLog.CreateUserId = ManageProvider.Provider.Current().UserId;
                SysLog.CreateUserName = ManageProvider.Provider.Current().Account;
                SysLog.CreateTime = DateTime.Now;
                SysLog.ModuleId =int.Parse(DESEncrypt.Decrypt(CookieHelper.GetCookie("ModuleId")));
                if (Remark == "")
                {
                    SysLog.Remark = DatabaseCommon.GetClassName<T>();
                }
                else
                {
                    SysLog.Remark = Remark;
                }
              
                SysLog.Status = Status;
              int newid=database.Insert(SysLog, isOpenTrans);
                //添加日志详细信息
                Type objTye = typeof(T);
                StringBuilder sbNewValue = new StringBuilder();
                foreach (PropertyInfo pi in objTye.GetProperties())
                {
                    object value = pi.GetValue(entity, null);
                    if (value != null && value.ToString() != "&nbsp;" && value.ToString() != "")
                    {
                        sbNewValue.Append(pi.Name + ":" + value);
                      
                    }
                }
                SysLogDetail syslogdetail = new SysLogDetail();
                syslogdetail.SysLogId = newid;
                syslogdetail.PropertyField = "";
                syslogdetail.PropertyName = "";
                syslogdetail.NewValue = sbNewValue.ToString();
                syslogdetail.CreateTime = DateTime.Now;
                database.Insert(syslogdetail, isOpenTrans);
                database.Commit();
            }
            catch (Exception e)
            {
                string abc = e.Message;
                database.Rollback();
            }
        }

        /// <summary>
        /// 写入作业日志（更新操作）
        /// </summary>
        /// <param name="oldObj">旧实体对象</param>
        /// <param name="newObj">新实体对象</param>
        /// <param name="OperationType">操作类型</param>
        /// <param name="Status">状态</param>
        /// <param name="Remark">操作说明</param>
        /// <returns></returns>
        public void WriteLog<T>(T oldObj, T newObj, OperationType OperationType, int Status, string Remark = "")
        {
            IDatabase database = DataFactory.Database();
            DbTransaction isOpenTrans = database.BeginTrans();
            try
            {
            
                SysLog.ObjectId = DatabaseCommon.GetKeyFieldValue(newObj).ToString();
                SysLog.LogType =(int)OperationType;
                SysLog.IPAddress = ManageProvider.Provider.Current().IPAddress;
                SysLog.IPAddressName = ManageProvider.Provider.Current().IPAddressName;
                SysLog.CreateUserId = ManageProvider.Provider.Current().UserId;
                SysLog.CreateUserName = ManageProvider.Provider.Current().Account;
                SysLog.CreateTime = DateTime.Now;
                SysLog.ModuleId =int.Parse(DESEncrypt.Decrypt(CookieHelper.GetCookie("ModuleId")));
                if (Remark == "")
                {
                    SysLog.Remark = DatabaseCommon.GetClassName<T>();
                }
                else
                {
                    SysLog.Remark = Remark;
                }

              
                SysLog.Status = Status;
               int newid=database.Insert(SysLog, isOpenTrans);
                //添加日志详细信息
                Type objTye = typeof(T);
                StringBuilder sbNewValue = new StringBuilder();
                StringBuilder sbOldValue = new StringBuilder();
                foreach (PropertyInfo pi in objTye.GetProperties())
                {
                    object oldVal = pi.GetValue(oldObj, null);
                    object newVal = pi.GetValue(newObj, null);
                    if (!Equals(oldVal, newVal))
                    {
                        if (oldVal != null && oldVal.ToString() != "&nbsp;" && oldVal.ToString() != "" && newVal != null && newVal.ToString() != "&nbsp;" && newVal.ToString() != "")
                        {
                            sbNewValue.Append(pi.Name + ":" + newVal+",");
                            sbOldValue.Append(pi.Name + ":" + oldVal + ",");
                        }
                    }
                }
                SysLogDetail syslogdetail = new SysLogDetail();
                syslogdetail.SysLogId = newid;
                syslogdetail.PropertyField = "";
                syslogdetail.CreateTime = DateTime.Now;
                syslogdetail.PropertyName = "";
                syslogdetail.NewValue = sbNewValue.ToString();
                syslogdetail.OldValue = sbOldValue.ToString();
                database.Insert(syslogdetail, isOpenTrans);
                database.Commit();
            }
            catch(Exception e)
            {
                database.Rollback();
            }
        }


        /// <summary>
        /// 写入作业日志（删除操作）
        /// </summary>
        /// <param name="oldObj">旧实体对象</param>
        /// <param name="KeyValue">对象主键</param>
        /// <param name="Status">状态</param>
        /// <param name="Remark">操作说明</param>
        public void WriteLog<T>(string[] KeyValue, int Status, string Remark = "") where T : new()
        {
            IDatabase database = DataFactory.Database();
            DbTransaction isOpenTrans = database.BeginTrans();
            try
            {
                foreach (var item in KeyValue)
                {
                    T Oldentity = database.FindEntity<T>(item.ToString());
                    SysLog.ObjectId = item;
                    SysLog.LogType =(int)OperationType.Delete;
                    SysLog.IPAddress = ManageProvider.Provider.Current().IPAddress;
                    SysLog.IPAddressName = ManageProvider.Provider.Current().IPAddressName;
                    SysLog.CreateUserId = ManageProvider.Provider.Current().UserId;
                    SysLog.CreateUserName = ManageProvider.Provider.Current().Account;
                    SysLog.CreateTime = DateTime.Now;
                    SysLog.ModuleId =int.Parse(DESEncrypt.Decrypt(CookieHelper.GetCookie("ModuleId")));
                    if (Remark == "")
                    {
                        SysLog.Remark = DatabaseCommon.GetClassName<T>();
                    }
                    else
                    {
                        SysLog.Remark = Remark;
                    }
                 
                    SysLog.Status = Status;
                   int newid= database.Insert(SysLog, isOpenTrans);
                    //添加日志详细信息
                    Type objTye = typeof(T);
                    StringBuilder sbOldValue = new StringBuilder();
                    foreach (PropertyInfo pi in objTye.GetProperties())
                    {
                        object value = pi.GetValue(Oldentity, null);
                        if (value != null && value.ToString() != "&nbsp;" && value.ToString() != "")
                        {

                            sbOldValue.Append(pi.Name + ":" + value + ",");
                          
                        }
                    }
                    SysLogDetail syslogdetail = new SysLogDetail();

                    syslogdetail.SysLogId = newid;
                    syslogdetail.PropertyField = "";
                    syslogdetail.PropertyName = "";
                    syslogdetail.NewValue = sbOldValue.ToString();
                    syslogdetail.CreateTime = DateTime.Now;
                    database.Insert(syslogdetail, isOpenTrans);
                }
                database.Commit();
            }
            catch
            {
                database.Rollback();
            }
        }


        /// <summary>
        /// 写入作业日志（删除操作）
        /// </summary>
        /// <param name="oldObj">旧实体对象</param>
        /// <param name="KeyValue">对象主键</param>
        /// <param name="Status">状态</param>
        /// <param name="Remark">操作说明</param>
        public void WriteLog<T>(List<T> obj, int Status, string Remark = "") where T : new()
        {
            IDatabase database = DataFactory.Database();
            DbTransaction isOpenTrans = database.BeginTrans();
            try
            {
                foreach (var item in obj)
                {
                   // T Oldentity = database.FindEntity<T>(item.ToString());
                    SysLog.ObjectId = DatabaseCommon.GetKeyFieldValue(item).ToString();
                    SysLog.LogType = (int)OperationType.Delete;
                    SysLog.IPAddress = ManageProvider.Provider.Current().IPAddress;
                    SysLog.IPAddressName = ManageProvider.Provider.Current().IPAddressName;
                    SysLog.CreateUserId = ManageProvider.Provider.Current().UserId;
                    SysLog.CreateUserName = ManageProvider.Provider.Current().Account;
                    SysLog.CreateTime = DateTime.Now;
                    SysLog.ModuleId = int.Parse(DESEncrypt.Decrypt(CookieHelper.GetCookie("ModuleId")));
                    if (Remark == "")
                    {
                        SysLog.Remark = DatabaseCommon.GetClassName<T>();
                    }
                    else
                    {
                        SysLog.Remark = Remark;
                    }

                    SysLog.Status = Status;
                    int newid = database.Insert(SysLog, isOpenTrans);
                    //添加日志详细信息
                    Type objTye = typeof(T);
                    StringBuilder sbOldValue = new StringBuilder();
                    foreach (PropertyInfo pi in objTye.GetProperties())
                    {
                        object value = pi.GetValue(item, null);
                        if (value != null && value.ToString() != "&nbsp;" && value.ToString() != "")
                        {

                            sbOldValue.Append(pi.Name + ":" + value + ",");

                        }
                    }
                    SysLogDetail syslogdetail = new SysLogDetail();

                    syslogdetail.SysLogId = newid;
                    syslogdetail.PropertyField = "";
                    syslogdetail.PropertyName = "";
                    syslogdetail.NewValue = sbOldValue.ToString();
                    syslogdetail.CreateTime = DateTime.Now;
                    database.Insert(syslogdetail, isOpenTrans);
                }
                database.Commit();
            }
            catch
            {
                database.Rollback();
            }
        }


        public void WriteLog<T>(List<T> obj, OperationType type, int Status, string Remark = "") where T : new()
        {
            IDatabase database = DataFactory.Database();
            DbTransaction isOpenTrans = database.BeginTrans();
            try
            {
                foreach (var item in obj)
                {
                    // T Oldentity = database.FindEntity<T>(item.ToString());
                    SysLog.ObjectId = DatabaseCommon.GetKeyFieldValue(item).ToString();
                    SysLog.LogType = (int)type;
                    SysLog.IPAddress = ManageProvider.Provider.Current().IPAddress;
                    SysLog.IPAddressName = ManageProvider.Provider.Current().IPAddressName;
                    SysLog.CreateUserId = ManageProvider.Provider.Current().UserId;
                    SysLog.CreateUserName = ManageProvider.Provider.Current().Account;
                    SysLog.CreateTime = DateTime.Now;
                    SysLog.ModuleId = int.Parse(DESEncrypt.Decrypt(CookieHelper.GetCookie("ModuleId")));
                    if (Remark == "")
                    {
                        SysLog.Remark = DatabaseCommon.GetClassName<T>();
                    }
                    else
                    {
                        SysLog.Remark = Remark;
                    }

                    SysLog.Status = Status;
                    int newid = database.Insert(SysLog, isOpenTrans);
                    //添加日志详细信息
                    Type objTye = typeof(T);
                    StringBuilder sbOldValue = new StringBuilder();
                    foreach (PropertyInfo pi in objTye.GetProperties())
                    {
                        object value = pi.GetValue(item, null);
                        if (value != null && value.ToString() != "&nbsp;" && value.ToString() != "")
                        {

                            sbOldValue.Append(pi.Name + ":" + value + ",");

                        }
                    }
                    SysLogDetail syslogdetail = new SysLogDetail();

                    syslogdetail.SysLogId = newid;
                    syslogdetail.PropertyField = "";
                    syslogdetail.PropertyName = "";
                    syslogdetail.NewValue = sbOldValue.ToString();
                    syslogdetail.CreateTime = DateTime.Now;
                    database.Insert(syslogdetail, isOpenTrans);
                }
                database.Commit();
            }
            catch
            {
                database.Rollback();
            }
        }

    }
}
