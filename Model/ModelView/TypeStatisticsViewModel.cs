using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.ModelView
{

    public   class TypeStatisticsViewModel
    {
        [JsonProperty("total")]
        public int Total { get; set; }
        [JsonProperty("list")]
        public List<ActivityType> List { get; set; }

    }
    public class ActivityType
    {
        [JsonProperty("TypeName")]
        public string TypeName { get; set; }

        [JsonProperty("quantity")]
        public int Quantity { get; set; }
    }
}
