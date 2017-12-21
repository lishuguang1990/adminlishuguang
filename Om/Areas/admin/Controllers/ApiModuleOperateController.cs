using BLL;
using LeaRun.Utilities;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using MallWCF.DBHelper;
using System.Data.Common;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Utilities;

namespace Om.Areas.admin.Controllers
{
    public class ApiModuleOperateController : ApiController
    {
        SysLogBll sysLogBll = new SysLogBll();
        ModuleOperateBll ModuleOperateBll = new ModuleOperateBll();
        //模块操作添加
        public Dictionary<string, object> OperateAdd(ModuleOperate model)
        {
            model.CreateTime = DateTime.Now;
            model.CreateUserId = ManageProvider.Provider.Current().UserId;
            model.CreateUserName = ManageProvider.Provider.Current().Account;
            if (model.ModuleOperateId == 0)
            {
                if (ModuleOperateBll.ModuleOperateAdd(model) > 0)
                {

                    sysLogBll.WriteLog<ModuleOperate>(model, OperationType.Add, (int)LogSatus.Success, "模块操作添加");
                    return new Dictionary<string, object>
                  {
                      { "code",1},
                  };
                }
                else
                {
                    return new Dictionary<string, object>
                  {
                      { "code",0},
                      { "msg","添加失败"}
                  };
                }
            }
            else
            {
                ModuleOperate oldmodel = new ModuleOperate();
                oldmodel = ModuleOperateBll.GetModel(model.ModuleOperateId);
                if (ModuleOperateBll.ModuleOperateEdit(model) > 0)
                {
                    sysLogBll.WriteLog<ModuleOperate>(oldmodel, model, OperationType.Update, (int)LogSatus.Success, "模块操作修改");

                    return new Dictionary<string, object>
                  {
                      { "code",1},
                  };
                }
                else
                {
                    return new Dictionary<string, object>
                  {
                      { "code",0},
                      { "msg","修改失败"}
                  };
                }
            }
           

        }
        //获取所有模块
        [HttpPost]
        public Dictionary<string, object> GetAllOperate()
        {
            IDatabase database = DataFactory.Database();
            var context = (HttpContextBase)Request.Properties["MS_HttpContext"];
            var request = context.Request;
            string roleid = request.Form["roleid"];
            ModuleBll ModuleBll = new ModuleBll();
            ModuleOperateBll ModuleOperateBll = new ModuleOperateBll();
            List<Module> listmodel = ModuleBll.GetModuleList();
            List<ModuleOperate> moduleoperate = ModuleOperateBll.GetList();
            Dictionary<string, object> dic = new Dictionary<string, object>();
            OpeateModuleView model = new OpeateModuleView();
            List<ModuleView> listModuleView = new List<ModuleView>();

            List<ModuleRole> listmodulerole = database.FindList<ModuleRole>(" and RoleId="+roleid);
            List<ModuleOperateRole> listmoduleoperaterole = database.FindList<ModuleOperateRole>(" and RoleId = " + roleid);

            foreach (var item in listmodel)
            {

                ModuleView ModuleView = new ModuleView();
                ModuleView.ModuleId = item.ModuleId;
                ModuleView.ModuleName = item.ModuleName;
                ModuleView.ParentId = item.ParentId;
                int flag = 0;
                if (listmodulerole.Where(a => a.ModuleId == item.ModuleId).ToList().Count > 0)
                {
                    flag = 1;
                    ModuleView.ischecked = true;
                }
                else
                {
                    ModuleView.ischecked = false;
                }
                   
               
                ModuleView.id = item.ModuleId;
                List<ModuleOperateView> listModuleOperateView = new List<ModuleOperateView>();
                foreach (var item1 in moduleoperate)
                {
                    ModuleOperateView moduleOperateView = new ModuleOperateView();
                    if (item.ModuleId == item1.ModuleId)
                    {
                        if (flag == 0)
                        {
                            moduleOperateView.IsCheck = false;
                        }
                        else
                        {
                            if (listmoduleoperaterole.Where(a => a.ModuleOperateId == item1.ModuleOperateId).ToList().Count > 0)
                            {
                                moduleOperateView.IsCheck = true;
                            }
                            else
                            {
                                moduleOperateView.IsCheck = false;
                            }
                        }
                        moduleOperateView.OperateId = item1.ModuleOperateId;
                        moduleOperateView.OperateName = item1.ModuleOperateName;
                        listModuleOperateView.Add(moduleOperateView);
                    }
                }
                ModuleView.List = listModuleOperateView;
                listModuleView.Add(ModuleView);
            }
         
            model.ModuleList = listModuleView;
            dic.Add("module", model);
            return dic;
        }
        [HttpPost]
        //复权
        public Dictionary<string, object> CreateModuleOperate()
        {
            var context = (HttpContextBase)Request.Properties["MS_HttpContext"];
            var request = context.Request;
            string operate = request.Form["operate"];
            string roleid = request.Form["roleid"];
            OpeateModuleView model = operate.JsonToEntity<OpeateModuleView>();
            IDatabase database = DataFactory.Database();
            DbTransaction isOpenTrans = database.BeginTrans();
            try
            {
                StringBuilder sbModuleOperateRole = new StringBuilder("delete  ModuleOperateRole where RoleId=@RoleId");
                SqlParameter[] par = { new SqlParameter("@RoleId", SqlDbType.Int) };
                par[0].Value = int.Parse(roleid);
                int newid = database.ExecuteBySql(sbModuleOperateRole, par, isOpenTrans);
                StringBuilder sbModuleRole = new StringBuilder("delete ModuleRole where RoleId=@RoleId");
                int newid1= database.ExecuteBySql(sbModuleRole, par, isOpenTrans);
              
                foreach (var item in model.ModuleList)
                {
                    if (item.ischecked)
                    {
                        ModuleRole moduleRole = new ModuleRole();
                        moduleRole.RoleId = int.Parse(roleid);
                        moduleRole.ModuleId = item.ModuleId;
                        database.Insert(moduleRole, isOpenTrans);
                        foreach (var item1 in item.List)
                        {
                            if (item1.IsCheck)
                            {
                                ModuleOperateRole moduleOperateRole = new ModuleOperateRole();
                                moduleOperateRole.RoleId= int.Parse(roleid);
                                moduleOperateRole.ModuleOperateId = item1.OperateId;
                                database.Insert(moduleOperateRole, isOpenTrans);
                            }
                        }
                    }

                    
                }
                database.Commit();

                     return new Dictionary<string, object>
                    {
                        { "code","1"}
                    };
            }
            catch (Exception)
            {

                database.Rollback();
                    return new Dictionary<string, object>
                {
                    { "code","0"}
                };
            }
      
         
        }
        [HttpPost]
        public Dictionary<string, object> GetUserOperate()
        {
            IDatabase database = DataFactory.Database();
            int userid = ManageProvider.Provider.Current().UserId;
            string moduleid = DESEncrypt.Decrypt(CookieHelper.GetCookie("ModuleId"));
            var model = database.FindEntity<Module>(moduleid);
            var parentname = database.FindEntity<Module>("ModuleId", model.ParentId);
            var list = database.FindListBySql<ModuleOperate>(" select[ModuleOperateId],[ModuleOperateName],[JsEvent],Icon from[ModuleOperate] where[ModuleOperateId] in (select ModuleOperateId from ModuleOperateRole where RoleId  in (select RoleId from UserRole where UserId = " + userid + " )) and ModuleId ="+ moduleid + "");
            return new Dictionary<string, object>
            {

                  { "list",list },
                  { "parentname",parentname.ModuleName},
                   { "name",model.ModuleName},


            };
        }
        /// <summary>
        /// 删除按钮
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public Dictionary<string, object> ModuleOperateDel()
        {
            IDatabase database = DataFactory.Database();
            DbTransaction isOpenTrans = database.BeginTrans();
            var context = (HttpContextBase)Request.Properties["MS_HttpContext"];
            var request = context.Request;
            string operateidlist = request.Form["operateid"];
            List<ModuleOperate> list = new List<ModuleOperate>();
            string[] arrid = operateidlist.Split(',');
            for (int i = 0; i < operateidlist.Length; i++)
            {
                ModuleOperate model = new ModuleOperate();

            }
            try
            {
                StringBuilder sbModuleOperateRole = new StringBuilder(" delete   ModuleOperateRole where ModuleOperateId in ("+ operateidlist + ")");
                database.ExecuteBySql(sbModuleOperateRole, isOpenTrans);
                StringBuilder sbModuleOperate = new StringBuilder("delete ModuleOperate where ModuleOperateId in (" + operateidlist + ")");
                database.ExecuteBySql(sbModuleOperate, isOpenTrans);
                SysLogBll sysLogBll = new SysLogBll();
                database.Commit();
                sysLogBll.WriteLog<ModuleOperate>(list, (int)Utilities.LogSatus.Success, "模块按钮删除删除");

                return new Dictionary<string, object>
                {
                    {  "code","1"  }
                };

            }
            catch (Exception)
            {

                return new Dictionary<string, object>
                {
                    {  "code","0"  }
                };
            }
    
        }

    }
}
