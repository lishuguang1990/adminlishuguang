﻿using AppLibrary.WriteExcel;
using BLL;
using LeaRun.Utilities;
using log4net;
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
    [RoutePrefix("api/ApiClubActivity")]
    [Route("{action}")]
    public class ApiClubActivityController : ApiController
    {
        ILog log = log4net.LogManager.GetLogger(typeof(ApiClubActivityController));
        [HttpPost]
        public Dictionary<string, object> GetActivityList(JqGridParam jqgridparam)
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
            data = re.FindTablePageBySql("select [clubactivityinfoid],[clubname],[clubactivitytypeid],[activitydate],[activitycost],[createtime],[createuserid],[isshow] ,[isdelete],[createusername],[clubactivitytypename]  from C_ClubActivityInfoView where " + strwhere + "", ref jqgridparam);
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

        public Dictionary<string, object> Add(C_ClubActivityInfo model)
        {
            C_ClubActivityInfoBll bll = new C_ClubActivityInfoBll();
      
               
            if (model.ClubActivityInfoId > 0)
            {
                var oldmodel = bll.GetModel(model.ClubActivityInfoId);
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
            C_ClubActivityInfoBll bll = new C_ClubActivityInfoBll();
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
        public void Export()
        {
            //俱乐部名称
            var clubname = HttpContext.Current.Request.QueryString["clubname"].ToString();
            //类型
            var saleactivitytypeid = HttpContext.Current.Request.QueryString["saleactivitytypeid"].ToString();
            var begindate = HttpContext.Current.Request.QueryString["begindate"].ToString();
            var enddate = HttpContext.Current.Request.QueryString["enddate"].ToString();
            IDatabase database = DataFactory.Database();
            IRepository<ActivityViewModel> re = new Repository<ActivityViewModel>();
            DataTable data = new DataTable();
            string strwhere = " IsDelete=0  ";
            if (!string.IsNullOrEmpty(clubname))
            {
                strwhere += " and ClubName like '%" + clubname + "%'";
            }
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
            data = database.FindTableBySql("select [clubactivityinfoid],[clubname],[clubactivitytypeid],[activitydate],[activitycost],[createtime],[createuserid],[isshow] ,[isdelete],[createusername],[clubactivitytypename]  from C_ClubActivityInfoView where " + strwhere+ " order by ClubActivityInfoId desc");
            AppLibrary.WriteExcel.XlsDocument doc = new AppLibrary.WriteExcel.XlsDocument();
            // HttpContext.Current.Response.Write();
            doc.FileName = DateTime.Now.ToString("yyyyMMddHHmmss") + ".xls";
            string sheetname = "SHEET";
            Worksheet sheet = doc.Workbook.Worksheets.Add(sheetname);
            Cells cells = sheet.Cells;
            XF XFstyle = doc.NewXF();
            XFstyle.HorizontalAlignment = HorizontalAlignments.Centered;
            cells.Add(1, 1, "车主俱乐部名称");
            cells.Add(1, 2, "活动类别");
            cells.Add(1, 3, "日期");
            cells.Add(1, 4, "活动成本");
            int f = 1;
            for (int i = 0; i < data.Rows.Count; i++)
            {
                f++;
                cells.Add(f, 1, data.Rows[i]["clubname"]);
                cells.Add(f, 2, data.Rows[i]["clubactivitytypename"]);
                cells.Add(f, 3, DateTime.Parse(data.Rows[i]["activitydate"].ToString()).ToString("yyyy-MM-dd"));
                cells.Add(f, 4, data.Rows[i]["activitycost"]);
            }
            doc.Send();
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.End();
        }


        [HttpPost]
        public Dictionary<string, object> IntoClubActivityInfo()
        {
            C_ClubActivityInfoBll bll = new C_ClubActivityInfoBll();
            string url = HttpContext.Current.Request.Form["url"].ToString();
            string filename = HttpContext.Current.Request.Form["filename"].ToString();
            DataSet ds = ExportFile.ExcelSqlConnection(HttpContext.Current.Server.MapPath(url), "Info");           //调用自定义方法
            log.Debug(ds.Tables[0].Rows.Count);
            DataRow[] dr = ds.Tables[0].Select();
            int successcount = 0;
            int failcount = 0;
            for (int i = 0; i < dr.Length; i++)
            {
                try
                {
                    C_ClubActivityInfo model = new C_ClubActivityInfo();

                    model.ClubName = dr[i][0].ToString();
                    model.ClubActivityTypeId = int.Parse(dr[i][1].ToString());
                    model.ActivityDate = DateTime.Parse(dr[i][2].ToString());
                    model.ActivityCost = int.Parse(dr[i][3].ToString());
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
