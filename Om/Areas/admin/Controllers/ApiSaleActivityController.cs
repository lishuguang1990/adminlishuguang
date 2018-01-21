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
using Utilities.Base.File;

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
         //   HttpContext.Current.Response.Write();
            doc.FileName = DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls";
            string sheetname = "SHEET";
           Worksheet sheet = doc.Workbook.Worksheets.Add(sheetname);
            Cells cells = sheet.Cells;
            XF XFstyle = doc.NewXF();
            XFstyle.HorizontalAlignment = HorizontalAlignments.Centered;
            cells.Add(1, 1, "ceshi");
            cells.Add(1, 2, "ceshi");
            cells.Add(1, 3, "ceshi");
            cells.Add(1, 4, "ceshi");
            doc.Send();
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.End();
            //return new Dictionary<string, object>
            //{
            //    { "code",1},
            //    { "total",jqgridparam.total},
            //    { "page",jqgridparam.page},
            //    { "records",jqgridparam.records},
            //    { "rows",data},
            //};
        }
        [HttpPost]
        public Dictionary<string, object> IntoSalActivity()
        {
            T_SaleActivityBll bll = new T_SaleActivityBll();
            string url = HttpContext.Current.Request.Form["url"].ToString();
            string filename = HttpContext.Current.Request.Form["filename"].ToString();
            DataSet ds = ExportFile.ExcelSqlConnection(HttpContext.Current.Server.MapPath(url), "Info");           //调用自定义方法
            DataRow[] dr = ds.Tables[0].Select();
            int successcount = 0;
            int failcount = 0;
            for (int i = 0; i < dr.Length; i++)
            {
                try
                {
                    T_SaleActivity model = new T_SaleActivity();
                    model.AgencyId = int.Parse(dr[0][0].ToString());
                    model.AreaId = int.Parse(dr[i][1].ToString());
                    model.ActivityDate =DateTime.Parse(dr[i][2].ToString());
                    model.SaleActivityTypeId = int.Parse(dr[i][3].ToString());
                    model.PassengerFlow = int.Parse(dr[i][4].ToString());
                    model.LatentPassengerFlow = int.Parse(dr[i][5].ToString());
                    model.CarOwner = int.Parse(dr[i][6].ToString());
                    model.OrderQuantity = int.Parse(dr[i][7].ToString());
                    model.PrimeCost = int.Parse(dr[i][8].ToString());
                    model.LaterOrderQuantity = int.Parse(dr[i][9].ToString());
                    model.PublishWay = dr[i][10].ToString();
                    model.CreateUserId = ManageProvider.Provider.Current().UserId;
                    model.CreateUserName = ManageProvider.Provider.Current().Account;
                    model.CreateTime = DateTime.Now;
                    model.IsDelete = 0;
                    model.IsShow = 1;
                    if (bll.Add(model) > 0)
                    {
                        successcount++;
                    }
                    else
                    {
                        failcount++;
                    }

                }
                catch (Exception)
                {

                    failcount++;
                }

            }
            return new Dictionary<string, object>
            {
                { "code","1"},
                { "successcount",successcount},
                { "failcount",failcount},
                { "filename",filename},
                { "count",dr.Length}

            };
        }
    }
}
