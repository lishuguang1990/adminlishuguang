using LeaRun.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Om.Controllers
{
    /// <summary>
    /// 登录权限认证
    /// <author>
    public class LoginAuthorizeAttribute: AuthorizeAttribute
    {
        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            bool flag = filterContext.ActionDescriptor.IsDefined(typeof(AllowAnonymousAttribute), true) || filterContext.ActionDescriptor.ControllerDescriptor.IsDefined(typeof(AllowAnonymousAttribute), true);
            if (!flag)
            {
                if (!ManageProvider.Provider.IsOverdue("LoginModel"))
                {
                    filterContext.Result = new RedirectResult("/Index/Login");
                }
            }
          
        }

    }
}