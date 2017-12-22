using BLL;
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
    [RoutePrefix("api/ApiM_Solution")]
    [Route("{action}")]
    public class ApiM_SolutionController : ApiController
    {
        [HttpPost]
        public Dictionary<string, object> CreateM_Solution()
        {
            M_SolutionBll bll = new M_SolutionBll();
            string FactorySation = HttpContext.Current.Request.Form["FactorySation"].ToString();
            string Signal = HttpContext.Current.Request.Form["Signal"].ToString();
            string CauseId = HttpContext.Current.Request.Form["CauseId"].ToString();
            string HappenDate = HttpContext.Current.Request.Form["HappenDate"].ToString();
            string HappenTimes = HttpContext.Current.Request.Form["HappenTimes"].ToString();
            string EventTimes = HttpContext.Current.Request.Form["EventTimes"].ToString();
            


            string[] arrCauseId = CauseId.Split(',');
            string[] arrs = { "," };
            string[] arrHappenTimes = HappenTimes.Substring(0, HappenTimes.Length - 1).Split(arrs, StringSplitOptions.None);
            string[] arrEventTimes = EventTimes.Substring(0, EventTimes.Length - 1).Split(arrs, StringSplitOptions.None);

            M_Solution model = new M_Solution();
            for (int i = 0; i < arrCauseId.Length; i++)
            {
                if ((arrHappenTimes[i] != "" && arrHappenTimes[i] != "0")||(arrEventTimes[i] != "" && arrEventTimes[i] != "0"))
                {
                    model.FactorySation = FactorySation;
                    model.Signal = Signal;
                    model.CauseId = int.Parse(arrCauseId[i]);
                    model.HappenTimes = int.Parse(arrHappenTimes[i]);
                    model.Createtime = DateTime.Now;
                    model.HappenDate = DateTime.Parse(HappenDate);
                    model.CreateUserId = 1;
                    model.CreateUserName = "admin";
                    model.EventTimes = int.Parse(arrEventTimes[i]);
                    bll.M_SolutionAdd(model);

                }

             
            }
            return new Dictionary<string, object>
            {
                { "code","1"},

            };



        }
    }
}
