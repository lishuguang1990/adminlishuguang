using MallWCF.DBHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [PrimaryKey("ModuleRoleId")]
    public  class ModuleRole
    {
         public int ModuleRoleId { get; set; }
         public int ModuleId { get; set;}
         public int RoleId { get; set; }


    }
}
