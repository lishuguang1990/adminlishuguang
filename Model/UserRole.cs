using MallWCF.DBHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [PrimaryKey("UserRoleId")]
    public  class UserRole
    {
         public int UserRoleId { get; set; }

         public int UserId { get; set; }

         public int RoleId { get; set; }

    }
}
