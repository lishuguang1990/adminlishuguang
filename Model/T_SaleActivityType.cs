using MallWCF.DBHelper;
using Newtonsoft.Json;
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
        [JsonProperty("saleactivitytypeid")]
        public int SaleActivityTypeId { get; set; }
        [JsonProperty("saleactivitytypename")]
        public string SaleActivityTypeName { get; set;}
        public int SortCode { get; set; } = 0;

        public DateTime CreateTime { get; set; }

        public int CreateUserId { get; set; }

        public string CreateUserName { get; set; }

        public int IsShow { get; set; }
        public int IsDelete { get; set; } = 0;
    }
}
