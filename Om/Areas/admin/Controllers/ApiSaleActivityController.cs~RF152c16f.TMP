using MallWCF.DBHelper;
using Model.ModelView;
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
    [RoutePrefix("api/ApiSaleActivity")]
    [Route("{action}")]
    public class ApiSaleActivityController : ApiController
    {
        [HttpPost]
        public Dictionary<string, object> GetActivityList(JqGridParam jqgridparam)
        {
            //区域
            var activitareaid = HttpContext.Current.Request.Form["activitareaid"].ToString();
            //经销商
            var agencyid = HttpContext.Current.Request.Form["agencyid"].ToString();
            //类型
            var saleactivitytypeid = HttpContext.Current.Request.Form["saleactivitytypeid"].ToString();
            var begindate = HttpContext.Current.Request.Form["begindate"].ToString();
            var enddate = HttpContext.Current.Request.Form["enddate"].ToString();
            IDatabase database = DataFactory.Database();
            IRepository<ActivityViewModel> re = new Repository<ActivityViewModel>();
            DataTable data = new DataTable();
            string strwhere = "";
            if (!string.IsNullOrEmpty(activitareaid))
            {
                strwhere += " and ActivitAreaId=" + activitareaid;
            }
            if (!string.IsNullOrEmpty(agencyid))
            {
                strwhere += " and AgencyId=" + agencyid;
            }
            if (!string.IsNullOrEmpty(saleactivitytypeid))
            {
                strwhere += " and SaleActivityTypeId=" + saleactivitytypeid;
            }
            if (!string.IsNullOrEmpty(begindate))
            {
                strwhere += " and ActivityDate>'" + begindate + "'";
            }
            if (!string.IsNullOrEmpty(enddate))
            {
                strwhere += " and ActivityDate<'" + enddate + "'";
            }

            data = re.FindTablePageBySql("select * from View_Activity where 0=0 "+strwhere+"", ref jqgridparam);

             return new Dictionary<string, object>
            {
                { "code",1},
                { "total",jqgridparam.total},
                { "page",jqgridparam.page},
                { "records",jqgridparam.records},
                { "rows",data},
            };
        }
    }
}
