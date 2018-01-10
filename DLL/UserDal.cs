using LeaRun.Utilities;
using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
   public  class UserDal: RepositoryFactory<BaseUser>
    {
        private static UserDal _instance;
        private static object _object = new Object();
        public static UserDal GetInstance()
        {
            if (_instance == null)
            {
                lock (_object)
                {
                    if (_instance == null)
                    {
                        _instance = new UserDal();
                    }
                }
            }
            return _instance;
        }
        private UserDal()
        {

        }
        //获取用户列表
        public DataTable GetPageList(ref JqGridParam jqgridparam)
        {
            StringBuilder strSql = new StringBuilder();
            strSql.Append(@"select UserId,Account,Mobile, Email,CreateTime,Enabled from BaseUser where IsDelete=0 ");
            return Repository().FindTablePageBySql(strSql.ToString(),ref jqgridparam);
        }
        //登录
        public BaseUser UserLogin(string Account, string Password,out int result)
        {
            BaseUser entity = Repository().FindEntityByWhere(" and (Account='"+Account+ "' or Mobile='"+Account+"')");

            if (entity != null && entity.UserId > 0)
            {
                //有效
                if (entity.Enabled == 1)
                {
                    string dbPassword = Md5Helper.MD5(DESEncrypt.Encrypt(Password.ToLower(), "qwertyui"));
                    if (dbPassword == entity.UserPassword)
                    {
                        if (entity.LastVisit.HasValue)
                        {
                            entity.PreviousVisit = entity.LastVisit.Value;
                         }
                        entity.LastVisit = DateTime.Now;
                        int LogOnCount = CommonHelper.GetInt(entity.LogOnCount) + 1;
                        Repository().Update(entity);
                        result = 1;
                    }
                    else
                    {
                        //密码错误
                        result =3;
                    }
                }
                else
                {
                    //禁用
                    result = 2;
                }
                return entity;
             }
                //用户名不存在
                result = 0;
                return null;


        }

        public int AddUser(BaseUser model)
        {
            return Repository().Insert(model);
        }

        public BaseUser GetModel(int userid)
        {
            return Repository().FindEntity(userid);
        }

        public int EditUser(BaseUser model)
        {
            return Repository().Update(model);
        }

        public int UpdateAll(string idList)
        {
            StringBuilder sb = new StringBuilder("update BaseUser set IsDelete=1 where UserId in (" + idList + ")");
            return Repository().ExecuteBySql(sb);
        }
    }
}
