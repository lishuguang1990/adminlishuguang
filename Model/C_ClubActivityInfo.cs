using MallWCF.DBHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [PrimaryKey("ClubActivityInfoId")]
 
    public  class C_ClubActivityInfo
    {
        public int ClubActivityInfoId { get; set; }

        public string ClubName { get; set; }

        public int ClubActivityTypeId { get; set; }

        public DateTime ActivityDate { get; set; }

        public int ActivityCost { get; set; }

        public DateTime CreateTime { get; set; } = DateTime.Now;

        public int CreateUserId { get; set; }

        public int IsShow { get; set;}

        public int IsDelete { get; set; } = 0;

        public string CreateUserName { get; set; }
    }
}
