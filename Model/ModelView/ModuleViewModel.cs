using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.ModelView
{
   public  class ModuleViewModel
    {
        public int ModuleId { get; set; }
        public string name { get; set; }
        public int ParentId { get; set; }

        public bool isParent { get; set; }


    }
}
