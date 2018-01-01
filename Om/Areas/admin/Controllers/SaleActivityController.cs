using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Om.Areas.admin.Controllers
{
    [RouteArea("admin")]
    [RoutePrefix("SaleActivity")]
    [Route("{action}")]
    public class SaleActivityController : Controller
    {
        // GET: admin/SaleActivity
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult List()
        {
            return View();
        }
    }
}