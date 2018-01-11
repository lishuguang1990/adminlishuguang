using MallWCF.DBHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [PrimaryKey("ClubActivityTypeId")]
    public  class C_ClubActivityType
    {
        public int ClubActivityTypeId { get; set; }
        public string ClubActivityTypeName { get; set; }

        public int SortCode { get; set; }

        public DateTime CreateTime { get; set; } = DateTime.Now;

        public int CreateUserId { get; set; }

        public int IsShow { get; set; }

        public string CreateUserName { get; set; }

        public int IsDelete { get; set; } = 0;
    }
}
