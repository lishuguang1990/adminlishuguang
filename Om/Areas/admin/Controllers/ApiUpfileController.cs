using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using Utilities;

namespace Om.Areas.admin.Controllers
{
    [RoutePrefix("api/ApiUpfile")]
    [Route("{action}")]
    public class ApiUpfileController : ApiController
    {

        [HttpPost]
        public Dictionary<string,object> Hitchupfile()
        {
            //var context = (HttpContextBase)Request.Properties["MS_HttpContext"];
           // var request = context.Request;
            var fileList = HttpContext.Current.Request.Files;
            string uploadpath = HttpContext.Current.Server.MapPath(MyConfig.UploadPath) + "\\";
            if (fileList.Count > 0)
            {
                var random = new Random();

                var file = fileList[0];
                string fileExtension = Path.GetExtension(file.FileName);
                string newFileName = DateTime.Now.ToString("yyyyMMddHHmmssfff") + random.Next(1, 99) + fileExtension;
                string folder = DateTime.Now.ToString("yyyyMMdd");
                string newPath = uploadpath + folder + "\\";
                if (!Directory.Exists(newPath))
                {
                    Directory.CreateDirectory(newPath);
                }
                file.SaveAs(newPath + newFileName);
                string returnString = MyConfig.UploadPath +"/" + folder + "/" + newFileName;
                return new Dictionary<string, object>{
                {"errcode",1},
                {"url", returnString},
                { "filename",file.FileName}

                };

            }
            else
            {
                return new Dictionary<string, object>{
                {"errcode",0},
                };
            }
         
        }
    }
}
