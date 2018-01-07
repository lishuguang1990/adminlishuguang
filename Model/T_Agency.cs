using MallWCF.DBHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [PrimaryKey("AgencyId")]
    public   class T_Agency
    {
        public int AgencyId { get; set; }
        public string AgencyName { get; set; }
        public DateTime CreateTime { get; set; }

        public int CreateUserId { get; set; }

        public string CreateUserName { get; set; }

        public int IsShow { get; set; }

        public int IsDelete { get; set; } = 0;

        public int SortCode { get; set; }
    }
}
