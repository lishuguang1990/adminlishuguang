using MallWCF.DBHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [PrimaryKey("SaleActivityTypeId")]
    public  class T_SaleActivityType
    {
         public int SaleActivityTypeId { get; set; }
        public string SaleActivityTypeName { get; set;}
        public int SortCode { get; set; } = 0;

        public DateTime CreateTime { get; set; }

        public int CreateUserId { get; set; }

        public string CreateUserName { get; set; }

        public int IsShow { get; set; }
    }
}
