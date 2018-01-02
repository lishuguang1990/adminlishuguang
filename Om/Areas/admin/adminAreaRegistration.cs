﻿using System.Web.Mvc;

namespace Om.Areas.admin
{
    public class adminAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "admin";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "adminDefault",
                "admin/{controller}/{action}/{id}",
                new { controller = "Login", action = "Index", id = UrlParameter.Optional },
                  namespaces: new string[] { "Om.Areas.admin.Controllers" }
            );
        }
    }
}