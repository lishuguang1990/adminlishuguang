using BLL;
using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

namespace Om.Areas.admin.Controllers
{
    [RoutePrefix("api/ApiPredicSetting")]
    [Route("{action}")]
    public class ApiPredicSettingController : ApiController
    {
        PredicSettingBll bll = new PredicSettingBll();
        public Dictionary<string, object> PredicSettingAdd(PredicSetting model)
        {
            model.SettingType = 0;
            //添加
            if (model.PredictSettingId == 0)
            {
                bll.PredicSettingAdd(model);
            }
            else {
                bll.PredicSettingEdit(model);
            }
            return new Dictionary<string, object>
            {
                { "code","1"}
            };
        }

        [HttpPost]
        public Dictionary<string, object> PredicSettingList(JqGridParam jqgridparam)
        {

          
            var factory = HttpContext.Current.Request.Form["factory"].ToString();
            var key = HttpContext.Current.Request.Form["key"].ToString();
            IDatabase database = DataFactory.Database();
            IRepository<Module> re = new Repository<Module>();
            DataTable data = new DataTable();
            string strwhere = " 1=1 ";
            if (!string.IsNullOrEmpty(factory))
            {
                strwhere += " and FactorySation='" + factory + "'";
            }
            if (!string.IsNullOrEmpty(key))
            {
                strwhere += " and Signal like'%" + key + "%'";
            }
            data = re.FindTablePageBySql("select * from PredicSetting where "+ strwhere, ref jqgridparam);
            return new Dictionary<string, object>
            {
                { "code",1},
                { "total",jqgridparam.total},
                { "page",jqgridparam.page},
                { "records",jqgridparam.records},
                { "rows",data},
            };
        }
        [HttpPost]
        public void PredicSettingDel()
        {
            var id = HttpContext.Current.Request.Form["id"].ToString();
            string[] arr = id.Split(',');
            for (int i = 0; i < arr.Length; i++)
            {
                bll.PredicSettingDel(int.Parse(arr[i]));
            }
        }
    }
}
