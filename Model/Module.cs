using MallWCF.DBHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [PrimaryKey("ModuleId")]
    public class Module
    {
        public int ModuleId { get; set; }
        public string ModuleName { get; set; }

        public int ParentId { get; set; }

        public DateTime CreateTime { get; set; }

        public int Sort { get; set; }

        public int CreateUserId { get; set; }

        public string ControllerName { get; set; }

        public string ActionName { get; set; }
        public string Code { get; set; }

        public string Icon { get; set; }

        public int ModuleLevel { get; set; }

        public int IsShow { get; set; }


   }
}
