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
    [LoginAuthorize]
    public class SaleActivityController : Controller
    {
       
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
            T_ActivityAreaBll bll = new T_ActivityAreaBll();

            var list = bll.GetList();
            return View(list);
        }
      
        public ActionResult AreaAdd()
        {
            T_ActivityAreaBll bll = new T_ActivityAreaBll();
            var model = new T_ActivityArea();
            if (Request.QueryString["areaid"] != null)
            {
                model = bll.GetModel(int.Parse(Request.QueryString["areaid"].ToString()));

            }
            else
            {
                model.IsShow = 1;
            }

            return View(model);
        }
        [ModuleAuthorize]
        public ActionResult TypeList()
        {
            T_SaleActivityTypeBll bll = new T_SaleActivityTypeBll();
            var list = bll.GetList();
            return View(list);
        }
        public ActionResult TypeAdd()
        {
            var model = new T_SaleActivityType();
            var bll = new T_SaleActivityTypeBll();
            if (Request.QueryString["TypeId"] != null)
            {
                model = bll.GetModel(int.Parse(Request.QueryString["TypeId"].ToString()));
            }
            else
            {
                model.IsShow = 1;
            }
            return View(model);
        }
        [ModuleAuthorize]
        public ActionResult AgencyList()
        {
            T_AgencyBll bll = new T_AgencyBll();
            var list = bll.GetList();
            return View(list);
        }
        public ActionResult AgencyAdd()
        {
            var model = new T_Agency();
            var bll = new T_AgencyBll();
            if (Request.QueryString["AgencyId"] != null)
            {
                model = bll.GetModel(int.Parse(Request.QueryString["AgencyId"].ToString()));
            }
            else
            {
                model.IsShow = 1;
            }
            return View(model);
        }
    }
}