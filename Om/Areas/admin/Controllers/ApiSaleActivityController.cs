﻿using BLL;
using LeaRun.Utilities;
using MallWCF.DBHelper;
using Model;
using Model.ModelView;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using Utilities;

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
            data = re.FindTablePageBySql("select * from View_Activity where IsDelete=0 " + strwhere+"", ref jqgridparam);
            //for (int i = 0; i < data.Rows.Count; i++)
            //{
            //    DataRow row = data.NewRow();
            //    row["abc"] = "工作号"+i.ToString();
            //    data.Rows.Add(row);
            //}
            var newd = data.Columns.Add("publishwaycontent", typeof(String));
            var list = new Utilities.PublishWay().ToSelectListItem();
            for (int i = 0; i < data.Rows.Count; i++)
            {
                string str = data.Rows[i]["publishway"].ToString();
                if (!string.IsNullOrEmpty(str))
                {
                    string[] arrstr = str.Split(',');
                    string publishwaycontent = "";
                    if (!string.IsNullOrEmpty(str))
                    {
                        foreach (var item in list)
                        {
                            foreach (var item1 in arrstr)
                            {
                                if (item.Value == item1)
                                {
                                    publishwaycontent += item.Text + ",";
                                }
                            }
                        }

                    }
                    data.Rows[0]["publishwaycontent"] = publishwaycontent.Substring(0, publishwaycontent.Length - 1);
                }
                else
                {
                    data.Rows[0]["publishwaycontent"] = "";
                }
  


            }
              
      
        
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

        public Dictionary<string, object> Add(T_SaleActivity model)
        {
            T_SaleActivityBll bll = new T_SaleActivityBll();
           var RealPublishWay = HttpContext.Current.Request.Form["RealPublishWay"].ToString();
            model.PublishWay = RealPublishWay;
        
            if (model.SaleActivityId > 0)
            {
                var oldmodel = bll.GetModel(model.SaleActivityId);
                model.CreateUserId = oldmodel.CreateUserId;
                model.CreateUserName = oldmodel.CreateUserName;
                model.CreateTime = oldmodel.CreateTime;
                model.PublishWay = RealPublishWay;
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
                model.PublishWay = RealPublishWay;
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
            T_SaleActivityBll bll = new T_SaleActivityBll();
           var idList = HttpContext.Current.Request.Form["areaidlist"].ToString();
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
