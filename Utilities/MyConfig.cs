using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utilities
{
   public static class MyConfig
    {
        public static string UploadPath = ConfigurationManager.AppSettings["upfilepath"];
    }
}
