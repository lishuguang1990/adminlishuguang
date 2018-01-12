using BLL;
using LeaRun.Utilities;
using MallWCF.DBHelper;
using Model;
using Model.ModelView;
using Om.Areas.admin.UserAttribute;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.Http;

namespace Om.Areas.admin.Controllers
{
    [RoutePrefix("api/ApiClubInfo")]
    [Route("{action}")]
    public class ApiClubInfoController : ApiController
    {
        [HttpPost]
        public Dictionary<string, object> GetClubInfoList(JqGridParam jqgridparam)
        {
            //俱乐部名称
            var clubname = HttpContext.Current.Request.Form["clubname"].ToString();

            //类型
            var saleactivitytypeid = HttpContext.Current.Request.Form["saleactivitytypeid"].ToString();
            var begindate = HttpContext.Current.Request.Form["begindate"].ToString();
            var enddate = HttpContext.Current.Request.Form["enddate"].ToString();
            IDatabase database = DataFactory.Database();
            IRepository<ActivityViewModel> re = new Repository<ActivityViewModel>();
            DataTable data = new DataTable();
            string strwhere = " IsDelete=0  ";
            if (!string.IsNullOrEmpty(clubname))
            {
                strwhere += " and ClubName like '%" + clubname + "%'";
            }
            //if (!string.IsNullOrEmpty(agencyid))
            //{
            //    strwhere += " and AgencyId=" + agencyid;
            //}
            if (!string.IsNullOrEmpty(saleactivitytypeid))
            {
                strwhere += " and ClubActivityTypeId=" + saleactivitytypeid;
            }
            if (!string.IsNullOrEmpty(begindate))
            {
                strwhere += " and ActivityDate>='" + begindate + "'";
            }
            if (!string.IsNullOrEmpty(enddate))
            {
                strwhere += " and ActivityDate<='" + enddate + "'";
            }
            data = re.FindTablePageBySql("select [clubinfoid], [activityareaname],[clubdate],[buildedclubnumber],[planebuilderclubnumber],[notbuilderclubnumber],[createtime],[createuserid],[isshow] ,[isdelete],[createusername] from C_ClubInfoView where " + strwhere + "", ref jqgridparam);
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

        public Dictionary<string, object> Add(C_ClubInfo model)
        {
            C_ClubInfoBll bll = new C_ClubInfoBll();


            if (model.ClubInfoId > 0)
            {
                var oldmodel = bll.GetModel(model.ClubInfoId);
                model.CreateUserId = oldmodel.CreateUserId;
                model.CreateUserName = oldmodel.CreateUserName;
                model.CreateTime = oldmodel.CreateTime;
                if (bll.Update(model) > 0)
                {
                    return new Dictionary<string, object>
                     {
                         { "code",1}
                     };
                }
                else
                {
                    return new Dictionary<string, object>
                     {
                         { "code",0}
                     };
                }
            }
            else
            {
              
                model.CreateUserId = ManageProvider.Provider.Current().UserId;
                model.CreateUserName = ManageProvider.Provider.Current().Account;
                model.CreateTime = DateTime.Now;
                if (bll.Add(model) > 0)
                {
                    return new Dictionary<string, object>
                     {
                         { "code",1}
                     };
                }
                else
                {
                    return new Dictionary<string, object>
                     {
                         { "code",0}
                     };
                }
            }
        }

        [HttpPost]
        public Dictionary<string, object> Del()
        {
            C_ClubInfoBll bll = new C_ClubInfoBll();
            var idList = HttpContext.Current.Request.Form["idlist"].ToString();
            int result = bll.UpdateAll(idList);
            if (result > 0)
            {
                return new Dictionary<string, object>
                {
                    { "code",1},
                    { "result",result}
                };
            }
            else
            {
                return new Dictionary<string, object>
                 {
                     {"code",0}
                 };
            }
        }
    }
}