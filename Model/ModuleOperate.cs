using MallWCF.DBHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [PrimaryKey("ModuleOperateId")]
    public  class ModuleOperate
    {
        public int ModuleOperateId { get; set; }

        public string ModuleOperateName { get; set; }

        public DateTime CreateTime { get; set; }

        public int CreateUserId { get; set; }

        public string CreateUserName { get; set; }

        public int Enabled { get; set; }

        public int ModuleId { get; set; }

        public string JsEvent { get; set; }

        public string Icon { get; set; }

        public string Code { get; set; }

         public int Sort { get; set; }
    }
}
