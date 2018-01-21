using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Om.Controllers
{
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
    }
}