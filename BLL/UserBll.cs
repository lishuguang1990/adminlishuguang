using DAL;
using DLL;
using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
   public  class UserBll
    {
        public DataTable GetPageList(ref JqGridParam jqgridparam)
        {
            return UserDal.GetInstance().GetPageList(ref jqgridparam);
        }
        public BaseUser UserLogin(string Account, string Password, out int result)
        {
            return UserDal.GetInstance().UserLogin(Account, Password, out result);
        }
                //添加用户
        public Dictionary<string,object> AddUser(BaseUser model)
        {
            if (UserDal.GetInstance().AddUser(model) > 0)
            {
                return new Dictionary<string, object>
               {
                   { "code",1}
               };
            }
            else
            {
               return new Dictionary<string, object>
               {
                   { "code",0}
               };
            }
        }

        public BaseUser GetModel(int userid)
        {
            return UserDal.GetInstance().GetModel(userid);

        }
        public Dictionary<string,object> EditUser(BaseUser model)
        {
            if (UserDal.GetInstance().EditUser(model) > 0)
            {
                return new Dictionary<string, object>
               {
                   { "code",1}
               };
            }
            else
            {
                return new Dictionary<string, object>
               {
                   { "code",0}
               };
            }
        }

    }
}
