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
        public ActionResult index()
        {
            return View();
        }
        //public ActionResult Login(User model)
        //{

        //}
    }
}
