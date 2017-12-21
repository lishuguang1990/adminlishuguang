using MallWCF.DBHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [PrimaryKey("SolutionId")]
    public  class M_Solution
    {
        public int SolutionId { get; set; }
        public string FactorySation { get; set; }
        public string Signal { get; set; }

        public int CauseId { get; set; }

        public int HappenTimes { get; set; }

        public DateTime Createtime { get; set; }

        public int CreateUserId { get; set; }

        public string CreateUserName { get; set; }

        public DateTime HappenDate { get; set; }

        public int EventTimes { get; set; }
    }
}
