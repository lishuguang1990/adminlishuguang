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

    }
}
