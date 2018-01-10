using MallWCF.DBHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [PrimaryKey("UserId")]
    public  class BaseUser
    {
        public int UserId { get; set; }

        public string Account { get; set; }

        public string UserPassword { get; set; }

        public string Code { get; set; }

        public string RealName { get; set; }

        public string Gender { get; set; }
        public string Mobile { get; set; }
        public string Telephone { get; set; }
        public string OICQ { get; set; }
        public string Email { get; set; }
        public DateTime? ChangePasswordDate { get; set; }
        public int? LogOnCount { get; set; }
        public DateTime? FirstVisit { get; set; }
        public DateTime? PreviousVisit { get; set; }

        public DateTime? LastVisit { get; set; }
        public int AuditStatus { get; set; }
        public int?  AuditUserId { get; set; }

        public string AuditUserName { get; set; }
        public DateTime? AuditDateTime { get; set; }

        public string Remark { get; set; }
        public int Enabled { get; set; }

        public int SortCode { get; set; }
        public int DeleteMark { get; set; }

        public DateTime CreateTime { get; set; }
        public int CreateUserId { get; set; }

        public string CreateUserName { get; set; }

        public DateTime? ModifyDate { get; set; }

        public int? ModifyUserId { get; set;}

        public string ModifyUserName { get; set; }

        public int IsDelete { get; set; } = 0;

    }
}
