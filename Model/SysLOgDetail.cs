using MallWCF.DBHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [PrimaryKey("SysLogDetailId")]
    public  class SysLogDetail
    {
        public int SysLogDetailId { get; set; }

        public int SysLogId { get; set; }

        public string PropertyName { get; set; }

        public string PropertyField { get; set; }

        public string NewValue { get; set; }

        public string OldValue { get; set; }

        public DateTime CreateTime { get; set; }

    }
}
