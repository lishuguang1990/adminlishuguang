using MallWCF.DBHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [PrimaryKey("SysLogId")]
    public  class SysLog
    {
        public int SysLogId { get; set; }

        public int? ModuleId { get; set; }

        public string IPAddress { get; set; }

        public string IPAddressName { get; set; }

        public int LogType { get; set; }

        public DateTime CreateTime { get; set; }

        public int? CreateUserId { get; set; }

        public string CreateUserName { get; set; }

        public string Remark { get; set; }

        public int Status { get; set; }
        public string ObjectId { get; set; }
    }
}
