using BLL;
using LeaRun.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Om.Areas.admin.UserAttribute
{
    public class ModuleAuthorizeAttribute: AuthorizeAttribute
    {
        public ModuleAuthorizeAttribute()
        {

        }
        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            var controllerName = filterContext.RouteData.Values["controller"].ToString();
            var action = filterContext.RouteData.Values["action"].ToString();
            ModuleBll bll = new ModuleBll();
            string moduleId = "";
            if (!bll.ActionAuthorize(controllerName, action, ManageProvider.Provider.Current().UserId,out  moduleId))
              {
                ContentResult Content = new ContentResult();
                Content.Content = "很抱歉！您的权限不足，访问被拒绝";
                filterContext.Result = Content;
            }
            else
            {
                CookieHelper.WriteCookie("ModuleId", DESEncrypt.Encrypt(moduleId));

            }
            
        }
    }
}