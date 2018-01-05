using BLL;
using LeaRun.Utilities;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Om.Areas.admin.Controllers
{
    [RoutePrefix("api/ApiSaleActivityTyp")]
    [Route("{action}")]
    public class ApiSaleActivityTypeController : ApiController
    {
        T_SaleActivityTypeBll bll = new T_SaleActivityTypeBll();
        //public Dictionary<string, int> Add(T_SaleActivityType model)
        //{
        //    model.CreateUserId = ManageProvider.Provider.Current().UserId;
        //    model.CreateUserName = ManageProvider.Provider.Current().Account;
        //    model.CreateTime = DateTime.Now;
        //    //修改
        //    if (model.SaleActivityTypeId > 0)
        //    {
        //        bll.Add(model);
        //    }
        //    //添加
        //    else
        //    {

        //    }
        //}
    }
}
