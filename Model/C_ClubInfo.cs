using MallWCF.DBHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [PrimaryKey("ClubInfoId")]
    public  class C_ClubInfo
    {
        public int ClubInfoId { get; set; }
        public DateTime ClubDate { get; set; }

        public int BuildedClubNumber { get; set; }
        public int PlaneBuilderClubNumber { get; set; }

        public int NotBuilderClubNumber { get; set; }

        public DateTime CreateTime { get; set; }

        public int IsShow { get; set; }

        public int IsDelete { get; set; } = 0;

        public int CreateUserId { get; set; }

        public string CreateUserName { get; set; }
         public int ActivitAreaId { get; set;}

    }
}
