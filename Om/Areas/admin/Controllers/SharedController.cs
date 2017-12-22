using BLL;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Om.Areas.admin.Controllers
{
    [RouteArea("admin")]
    [RoutePrefix("Shared")]
    [Route("{action}")]
    public class SharedController : Controller
    {
        // GET: Share
        public PartialViewResult Menu()
        {
            ModuleBll Bll = new ModuleBll();

            List<Module> list = Bll.GetModuleListByUserId();
            return PartialView(list);
        }
    }
}