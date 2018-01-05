using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Om.App_Start
{
    public class CustomerErrorHadlerAttribute: HandleErrorAttribute
    {
        log4net.ILog log = log4net.LogManager.GetLogger(typeof(CustomerErrorHadlerAttribute));

        public override void OnException(ExceptionContext filterContext)
        {
            //base.OnException(filterContext);
            var e = filterContext.Exception;
            log.Info(e.Message);
            filterContext.ExceptionHandled = true;
        
            //var result = new ViewResult();
            //result.ViewName = "Error";
            //result.ViewBag.Error = e.Message;
            //filterContext.Result = result;
        }
    }
}