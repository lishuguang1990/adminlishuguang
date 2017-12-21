using MallWCF.DBHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [PrimaryKey("ModuleId")]
    public  class M_HitchInfo
    {
        public int HitchId { get; set; }
        public string AreaName { get; set; }

        public string FactorySation { get; set; }
        public string Signal { get; set; }
        public int HappenTimes { get; set; }
        public string SignalType { get; set; }
        public int HappenTimes1 { get; set; }

        public string MessageType { get; set; }
        public DateTime CreateTime { get;set;}

        public int CreateUserId { get; set; }

        public string CreateUserName { get; set; }

    }
}
