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
    [RoutePrefix("api/ApiActivityArea")]
    [Route("{action}")]
    public class ApiActivityAreaController : ApiController
    {
        T_ActivityAreaBll bll = new T_ActivityAreaBll();
        public Dictionary<string, object> Add(T_ActivityArea model)
        {
            model.CreateUserId = ManageProvider.Provider.Current().UserId;
            model.CreateUserName = ManageProvider.Provider.Current().Account;
            model.CreateTime = DateTime.Now;

            if (model.ActivitAreaId > 0)
            {
                var model1 = bll.GetModel(model.ActivitAreaId);
                model1.ActivityAreaName = model.ActivityAreaName;
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
        public Dictionary<string, object> AreaDel()
        {
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
  