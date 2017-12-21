using BLL;
using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.Http;

namespace Om.Areas.admin.Controllers
{
    public class ApiRoleController : ApiController
    {
        RoleBll bll = new RoleBll();
        public Dictionary<string, object> RoleAdd(Role model)
        {
           int newid=bll.RoleAdd(model);
            if (newid > 0)
            {
                return new Dictionary<string, object>
                {
                    { "code","1"}
                };
            }
            else
            {
                return new Dictionary<string, object>
                {
                    { "code","0"}
                };
            }
        }
        [HttpPost]
        public Dictionary<string, object> RoleDel()
        {

            IDatabase database = DataFactory.Database();
            DbTransaction isOpenTrans = database.BeginTrans();
           

            var context = (HttpContextBase)Request.Properties["MS_HttpContext"];
            var request = context.Request;
            string roleidlist = request.Form["roleidlist"];
            string[] arrid = roleidlist.Split(',');
            List<Role> listrole = database.FindList<Role>(" and RoleId in(" + roleidlist + ")");
            try
            {
                StringBuilder sbUserRole = new StringBuilder();
                sbUserRole.Append("delete UserRole where  RoleId in (" + roleidlist + ")" );
                database.ExecuteBySql(sbUserRole, isOpenTrans);
                StringBuilder sbModuleRole = new StringBuilder();
                sbModuleRole.Append("delete ModuleRole where  RoleId in (" + roleidlist + ") ");
                database.ExecuteBySql(sbModuleRole, isOpenTrans);
                StringBuilder sbModuleOperateRole = new StringBuilder();
                sbModuleOperateRole.Append("delete ModuleOperateRole where RoleId in (" + roleidlist + ")");
                database.ExecuteBySql(sbModuleOperateRole, isOpenTrans);
                StringBuilder sbRole = new StringBuilder();
                sbRole.Append("delete Role where RoleId in (" + roleidlist + ") ");
                database.ExecuteBySql(sbRole, isOpenTrans);
               
                SysLogBll sysLogBll = new SysLogBll();
                database.Commit();
                sysLogBll.WriteLog<Role>(listrole, (int)Utilities.LogSatus.Success, "角色删除");
              
                return new Dictionary<string, object>
                {
                    {  "code","1"  }
                };
            }
            catch (Exception)
            {
                database.Rollback();
                return new Dictionary<string, object>
                {
                    {  "code","0"  }
                };
              
                
            }

                //return new Dictionary<string, object>
                //{
                //    { "code","0"}
                //};
        }
    }
}
