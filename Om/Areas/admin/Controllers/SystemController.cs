using BLL;
using LeaRun.Utilities;
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
    [RoutePrefix("System")]
    [Route("{action}")]
    [LoginAuthorize]
    public class SystemController : Controller
    {
        // [ModuleAuthorize]
        // GET: System
        [ModuleAuthorize]
        public ActionResult ModuleManage()
        {
            ModuleBll Bll = new ModuleBll();
            List<Module> list = Bll.GetModuleList().OrderBy(a=>a.Sort).ToList();
            return View(list);
        }
        [ModuleAuthorize]
        public ActionResult RoleManage()
        {
            RoleBll Bll = new RoleBll();
            var modellist = Bll.GetRoleList();
            return View(modellist);
        }
   
        [ModuleAuthorize]
        public ActionResult UserManage()
        {
            return View();
        }
        public ActionResult UserAdd()
        {
            BaseUser model = new BaseUser();
            UserBll bll = new UserBll();
            if (Request.QueryString["UseridId"] != null)
            {
                model = bll.GetModel(int.Parse(Request.QueryString["UseridId"].ToString()));
            }
            
            return View(model);
        }

        public ActionResult ModuleAdd()
        {
            ModuleBll Bll = new ModuleBll();
            List<Module> list = Bll.GetModuleList();
            list = list.Where(a => a.ParentId == 0).ToList();
            ViewBag.ModuleParentList = list;
            Module model = new Module();
            if (Request.QueryString["ModuleId"] != null)
            {
                model = Bll.GetModel(int.Parse(Request.QueryString["ModuleId"].ToString()));
            }
             return View(model);
        }
        [ModuleAuthorize]
        public ActionResult OperateManage()
        {
            return View();
        }

        public ActionResult OperateList(int moduleid)
        {
            ModuleOperateBll Bll = new ModuleOperateBll();
            List<ModuleOperate> list = Bll.GetModuleOperateListByModuleId(moduleid);
            return View(list);
        }

        public ActionResult OperateAdd()
        {
            ModuleOperateBll Bll = new ModuleOperateBll();
              ModuleOperate model = new ModuleOperate();
            if (Request.QueryString["operateid"] != null)
            {
                model = Bll.GetModel(int.Parse(Request.QueryString["operateid"].ToString()));
            }
            else
            {
                model.ModuleId = int.Parse(Request.QueryString["moduleid"]);
                model.Enabled = 1;
            
            }

            return View(model);

        }
        public ActionResult RoleModuleOperate()
        {
            return View();
        }
        //角色添加
        public ActionResult RoleAdd()
        {
            Role model = new Role();
            RoleBll bll = new RoleBll();
            if (Request.QueryString["RoleId"] != null)
            {
                model = bll.GetModel(int.Parse(Request.QueryString["RoleId"]));
            }
           
            return View(model);
        }
        public ActionResult RoleUserAdd()
        {
            return View();
        }
        public ActionResult LoginOut()
        {
            ManageProvider.Provider.EmptyCurrent();
            return RedirectToAction("index", "Login");
        }
    }
}