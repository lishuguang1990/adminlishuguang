using LeaRun.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Om.Areas.admin.UserAttribute
{
    /// <summary>
    /// 登录权限认证
    /// <author>
    public class LoginAuthorizeAttribute: AuthorizeAttribute
    {
        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            if (!ManageProvider.Provider.IsOverdue())
            {
                filterContext.Result = new RedirectResult("/Login/index");
            }
        }

    }
}