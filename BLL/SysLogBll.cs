using DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utilities;

namespace BLL
{
    public class SysLogBll
    {
        public SysLogBll()
        {
            
        }
        public void WriteLog(string objectId, OperationType operationType, LogSatus logSatus, string remark = "")
        {
            SysLogDal.GetInstance().WriteLog(objectId, operationType, logSatus, remark);
        }
        public void WriteLog<T>(T entity, OperationType OperationType, int Status, string Remark = "")
        {
            SysLogDal.GetInstance().WriteLog(entity, OperationType, Status, Remark);
        }
        public void WriteLog<T>(T oldObj, T newObj, OperationType OperationType, int Status, string Remark)
        {
            SysLogDal.GetInstance().WriteLog(oldObj, newObj, OperationType, Status, Remark);
        }
        public void WriteLog<T>(string[] KeyValue, int Status, string Remark = "") where T : new()
        {
            SysLogDal.GetInstance().WriteLog<T>(KeyValue, Status, Remark);
        }
        public void WriteLog<T>(List<T> obj, int Status, string Remark = "") where T : new()
        {
            SysLogDal.GetInstance().WriteLog<T>(obj, Status, Remark);
        }

        public void WriteLog<T>(List<T> obj, OperationType type,int Status, string Remark = "") where T : new()
        {
            SysLogDal.GetInstance().WriteLog<T>(obj, type, Status, Remark);
        }
    }
}
