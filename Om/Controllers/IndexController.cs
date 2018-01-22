using BLL;
using LeaRun.Utilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Om.Controllers
{
    [LoginAuthorize]
    public class IndexController : Controller
    {
      
        // GET: Index
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult AverageCost()
        {
            return View();
        }
        [HttpGet]
        [AllowAnonymous]
        public ActionResult Login()
        {
            return View();
        }

        public ActionResult AveragePassengerFlow()
        {
            return View();
        }

        public ActionResult AverageOrder()
        {
            return View();
        }

        public ActionResult AverageLatentPassengerFlow()
        {
            return View();
        }

        public ActionResult AveragePassengerFlowChange()
        {
            return View();
        }

        public ActionResult AverageOrderCost()
        {
            return View();
        }

        public ActionResult PublishWayStatistics()
        {
            return View();
        }

        //[HttpPost]
        //public ActionResult Login(string UserName,string  PassWord)
        //{
        //    UserBll bll = new UserBll();
        //    return Json(bll.Login(UserName, PassWord));
        //}
        public ActionResult LoginOut()
        {
            ManageProvider.Provider.EmptyCurrent("LoginModel");
            return RedirectToAction("Login", "Index");
        }
    }
}