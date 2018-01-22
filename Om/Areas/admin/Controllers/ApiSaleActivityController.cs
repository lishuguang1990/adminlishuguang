using AppLibrary.WriteExcel;
using BLL;
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
                strwhere += " and ActivityDate>='" + begindate + "'";
            }
            if (!string.IsNullOrEmpty(enddate))
            {
                strwhere += " and ActivityDate<='" + enddate + "'";
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
                    data.Rows[i]["publishwaycontent"] = publishwaycontent.Substring(0, publishwaycontent.Length - 1);
                }
                else
                {
                    data.Rows[i]["publishwaycontent"] = "";
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

        public void Print()
        {
            //区域
            var activitareaid = HttpContext.Current.Request.QueryString["activitareaid"].ToString();
            //经销商
            var agencyid = HttpContext.Current.Request.QueryString["agencyid"].ToString();
            //类型
            var saleactivitytypeid = HttpContext.Current.Request.QueryString["saleactivitytypeid"].ToString();
            var begindate = HttpContext.Current.Request.QueryString["begindate"].ToString();
            var enddate = HttpContext.Current.Request.QueryString["enddate"].ToString();
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
                strwhere += " and ActivityDate>='" + begindate + "'";
            }
            if (!string.IsNullOrEmpty(enddate))
            {
                strwhere += " and ActivityDate<='" + enddate + "'";
            }
            data = database.FindTableBySql("select * from View_Activity where IsDelete=0 " + strwhere + "");
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
                   data.Rows[i]["publishwaycontent"] = publishwaycontent.Substring(0, publishwaycontent.Length - 1);
                }
                else
                {
                    data.Rows[i]["publishwaycontent"] = "";
                }
            }
            AppLibrary.WriteExcel.XlsDocument doc = new AppLibrary.WriteExcel.XlsDocument();
           // HttpContext.Current.Response.Write();
            doc.FileName = DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls";
            string sheetname = "SHEET";
            Worksheet sheet = doc.Workbook.Worksheets.Add(sheetname);
            Cells cells = sheet.Cells;
            XF XFstyle = doc.NewXF();
            XFstyle.HorizontalAlignment = HorizontalAlignments.Centered;
            cells.Add(1, 1, "经销商名称");
            cells.Add(1, 2, "区域");
            cells.Add(1, 3, "日期");
            cells.Add(1, 4, "活动类别");
            cells.Add(1, 5, "活动客流量");
            cells.Add(1, 6, "活动潜客量");
            cells.Add(1, 7, "活动车主量");
            cells.Add(1, 8, "活动现场订单量");
            cells.Add(1, 9, "活动成本金额");
            cells.Add(1, 10, "活动后续订单量");
            cells.Add(1, 11, "宣传类型");
            int f = 1;
            for (int i = 0; i < data.Rows.Count; i++)
            {
                f++;
                cells.Add(f, 1, data.Rows[i]["agencyname"]);
                cells.Add(f, 2, data.Rows[i]["activityareaname"]);
                cells.Add(f, 3,DateTime.Parse(data.Rows[i]["activitydate"].ToString()).ToString("yyyy-MM-dd"));
                cells.Add(f, 4, data.Rows[i]["saleactivitytypename"]);
                cells.Add(f, 5, data.Rows[i]["passengerflow"]);
                cells.Add(f, 6, data.Rows[i]["latentpassengerflow"]);
                cells.Add(f, 7, data.Rows[i]["carowner"]);
                cells.Add(f, 8, data.Rows[i]["orderquantity"]);
                cells.Add(f, 9, data.Rows[i]["primecost"]);
                cells.Add(f, 10, data.Rows[i]["laterorderquantity"]);
                cells.Add(f, 11, data.Rows[i]["publishwaycontent"]);
            }
            doc.Send();
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.End();
        }
    }
}
