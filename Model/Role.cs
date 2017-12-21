using MallWCF.DBHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [PrimaryKey("RoleId")]
    public  class Role
    {
        public int RoleId { get; set; }

        public string RoleName { get; set; }

        public DateTime CreateTime { get; set; }

        public int CreateUserId { get; set; }

        public int Sort { get; set; }

        public string Code { get; set; }

        public string Remark { get; set; }

        public int DeleteMark { get; set; }

        public string CreateUserName { get; set;}

        public DateTime ModifyDate { get; set; }

        public int ModifyUserId { get; set; }

        public string ModifyUserName { get; set;}


    }
}
