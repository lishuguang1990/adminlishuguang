using BLL;
using Model;
using Om.Areas.admin.UserAttribute;
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
        T_ActivityAreaBll bll = new T_ActivityAreaBll();
        // GET: admin/SaleActivity
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult List()
        {
            T_ActivityAreaBll bll = new T_ActivityAreaBll();
            var model = bll.GetList();
            return View(model);
        }
        [ModuleAuthorize]
        public ActionResult AreaList()
        {
         
            var list = bll.GetList();
            return View(list);
        }
      
        public ActionResult AreaAdd()
        {
            var model = new T_ActivityArea();
            if (Request.QueryString["areaid"] != null)
            model = bll.GetModel(int.Parse(Request.QueryString["areaid"].ToString()));
            return View(model);
        }
    }
}