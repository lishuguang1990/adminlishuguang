using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web.Mvc;

namespace Om.Areas.admin.Controllers
{
    //[RouteArea("admin")]
    //[RoutePrefix("login")]
    //[Route("{action=index}")]
    public class LoginController : Controller
    {
        log4net.ILog log = log4net.LogManager.GetLogger(typeof(LoginController));

        public ActionResult index()
        {
            log.Info("456");
            return View();
        }
        //public ActionResult Login(User model)
        //{

        //}
    }
}
