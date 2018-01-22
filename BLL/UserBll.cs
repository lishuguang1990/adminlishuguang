using DAL;
using LeaRun.Utilities;
using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utilities;

namespace BLL
{
   public  class UserBll
    {
        log4net.ILog log = log4net.LogManager.GetLogger(typeof(UserBll));

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
        public int UpdateAll(string idlist)
        {
            return UserDal.GetInstance().UpdateAll(idlist);
        }

        public Dictionary<string, object> Login(string Account,string UserPassword)
        {
            string Msg = "";
          
            int msg = 0;
            BaseUser base_user = UserLogin(Account, UserPassword, out msg);

            switch (msg)
            {
                case 0:
                    Msg = "账号不存在";
                    break;
                case 1:
                    RoleBll RoleBll = new RoleBll();
                    Role role = RoleBll.GetModelByUserId(base_user.UserId);

                    IManageUser mangeuser = new IManageUser();
                    mangeuser.UserId = base_user.UserId;
                    mangeuser.Account = base_user.Account;
                 
                    if (role != null)
                    {
                        mangeuser.RoleName = role.RoleName;
                        mangeuser.RoleId = role.RoleId;
                    }
                    else
                    {
                        mangeuser.RoleName = "";
                        mangeuser.RoleId = 0;
                    }
                    ManageProvider.Provider.AddCurrent(mangeuser, "LoginModel");
                 
                    break;
                case 2:
                    Msg = "账户锁定";
               
                    break;
                case 3:
                    Msg = "密码错误";
                    break;
            }

            return new Dictionary<string, object>
            {
                { "code",msg},
                { "msg",Msg}
            };
        }

    }
}
