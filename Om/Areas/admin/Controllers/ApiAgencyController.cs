using BLL;
using LeaRun.Utilities;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using Utilities.Base.File;

namespace Om.Areas.admin.Controllers
{
    [RoutePrefix("api/ApiAgency")]
    [Route("{action}")]
    public class ApiAgencyController : ApiController
    {
        T_AgencyBll bll = new T_AgencyBll();
        public Dictionary<string, object> Add(T_Agency model)
        {
            model.CreateUserId = ManageProvider.Provider.Current().UserId;
            model.CreateUserName = ManageProvider.Provider.Current().Account;
            model.CreateTime = DateTime.Now;

            if (model.AgencyId > 0)
            {
                var model1 = bll.GetModel(model.AgencyId);
                model1.AgencyName = model.AgencyName;
                model1.SortCode = model.SortCode;
                model1.IsShow = model.IsShow;


                if (bll.Update(model1) > 0)
                {
                    return new Dictionary<string, object>
                {
                    { "code","1" }
                };
                }
                else
                {
                    return new Dictionary<string, object>
                {
                    { "code","0" }
                };
                }
            }
            else
            {
                if (bll.Add(model) > 0)
                {
                    return new Dictionary<string, object>
                {
                    { "code","1" }
                };
                }
                else
                {
                    return new Dictionary<string, object>
                {
                    { "code","0" }
                };
                }
            }
        }
        [HttpPost]
        public Dictionary<string, object> Del()
        {
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
        [HttpPost]
        public Dictionary<string, object> IntoAgency()
        {
            T_AgencyBll bll = new T_AgencyBll();
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
                    T_Agency model = new T_Agency();
              
                    model.AgencyName = dr[i][0].ToString();
                    model.CreateUserId = ManageProvider.Provider.Current().UserId;
                    model.CreateUserName = ManageProvider.Provider.Current().Account;
                    model.CreateTime = DateTime.Now;
                    model.IsDelete = 0;
                    model.IsShow = 1;
                    model.SortCode = 0;
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
