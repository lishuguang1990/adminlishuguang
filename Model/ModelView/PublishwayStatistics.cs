using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.ModelView
{
   public  class PublishwayStatistics
    {
        [JsonProperty("month")]
        public int Month { get; set; }
        [JsonProperty("publishwaylist")]
        public List<int> Publishwaylist { get; set; }
    }
}
