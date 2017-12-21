using BLL;
using LeaRun.Utilities;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Mvc;
using Utilities;

namespace Om.Areas.admin.Controllers
{
    public class ApiLoginController : ApiController
    {
        UserBll UserBll = new UserBll();
        SysLogBll SysLogBll = new SysLogBll();
        public Dictionary<string, object> Login(BaseUser model)
        {
            string Msg = "";
            IPScanerHelper objScan = new IPScanerHelper();
            string IPAddress = NetHelper.GetIPAddress();
            objScan.IP = IPAddress;
            objScan.DataPath = System.Web.Hosting.HostingEnvironment.MapPath("~/Resource/IPScaner/QQWry.Dat");
            string IPAddressName = objScan.IPLocation();
            int msg = 0;
            BaseUser base_user = UserBll.UserLogin(model.Account, model.UserPassword, out msg);
        
            switch (msg)
            {
                case 0:
                    Msg = "账号不存在";
                    SysLogBll.WriteLog(model.Account, OperationType.Login, LogSatus.fail, "账号不存在、IP所在城市" + IPAddressName);
                    break;
                case 1:
                    RoleBll RoleBll = new RoleBll();
                    Role role = RoleBll.GetModelByUserId(base_user.UserId);
                  
                    IManageUser mangeuser = new IManageUser();
                    mangeuser.UserId = base_user.UserId;
                    mangeuser.Account = base_user.Account;
                    mangeuser.IPAddress = IPAddress;
                    mangeuser.IPAddressName = IPAddressName;
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
                    ManageProvider.Provider.AddCurrent(mangeuser);
                    SysLogBll.WriteLog(model.Account, OperationType.Login, LogSatus.Success, "登陆成功、IP所在城市" + IPAddressName);
                    break;
                case 2:
                    Msg = "账户锁定";
                    SysLogBll.WriteLog(model.Account, OperationType.Login, LogSatus.fail, "账户锁定、IP所在城市" + IPAddressName);
                    break;
                case 3:
                    Msg = "密码错误";
                    SysLogBll.WriteLog(model.Account, OperationType.Login, LogSatus.fail, "密码错误、IP所在城市" + IPAddressName);
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
