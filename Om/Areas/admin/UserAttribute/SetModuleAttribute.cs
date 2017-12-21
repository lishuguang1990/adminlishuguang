using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Om.Areas.admin.UserAttribute
{
    public class SetModuleAttribute: AuthorizeAttribute
    {
        public override void OnAuthorization(AuthorizationContext filterContext)
        {
           
        }
    }
}