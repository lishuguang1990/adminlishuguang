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
    [RoutePrefix("ClubActivity")]
    [Route("{action}")]
    [LoginAuthorize]
    public class ClubActivityController : Controller
    {
        [ModuleAuthorize]
        // GET: admin/ClubActivity
        public ActionResult ClubInfoList()
        {
            return View();
        }
        public ActionResult ClubInfoAdd()
        {
            var model = new C_ClubInfo();
            var bll = new C_ClubInfoBll();
            if (Request.QueryString["ClubInfoId"] != null)
           {
                model = bll.GetModel(int.Parse(Request.QueryString["ClubInfoId"].ToString()));
            }
            else
            {
                model.ClubDate = DateTime.Now;
                model.IsShow = 1;
            }
            return View(model);
        }
        public ActionResult ClubActivityAdd()
        {
            var model = new C_ClubActivityInfo();
            var bll = new C_ClubActivityInfoBll();
            if (Request.QueryString["ClubActivityInfoId"] != null)
            {
                model = bll.GetModel(int.Parse(Request.QueryString["ClubActivityInfoId"].ToString()));
            }
            else
            {
                model.ActivityDate = DateTime.Now;
                model.IsShow = 1;
            }
            return View(model);
         
        }
        [ModuleAuthorize]
        public ActionResult ClubActivityList()
        {
            return View();
        }
        [ModuleAuthorize]
        public ActionResult ClubTypeList()
        {
            C_ClubActivityTypeBll bll = new C_ClubActivityTypeBll();
            var list = bll.GetList();
            return View(list);
        }
        public ActionResult ClubTypeAdd()
        {
            var model = new C_ClubActivityType();
            var bll = new C_ClubActivityTypeBll();
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
        public ActionResult Hitchleadingin()
        {
            return View();
        }
    }
}