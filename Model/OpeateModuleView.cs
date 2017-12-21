using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
   public  class OpeateModuleView
    {
         public List<ModuleView> ModuleList { get; set; }
    }
    public class ModuleView
    {
         public int ModuleId { get; set; }
         public string ModuleName { get; set; }

         public bool ischecked { get; set; }

         public int ParentId { get; set; }

         public int id { get; set; }
        public List<ModuleOperateView> List { get; set; }

    }

    public class ModuleOperateView
    {
        public int OperateId { get; set; }

        public string OperateName { get; set; }

        public bool IsCheck { get; set; }
    }



}
