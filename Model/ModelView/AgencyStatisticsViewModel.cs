using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.ModelView
{
    public class AgencyStatisticsViewModel
    {
        [JsonProperty("agencyname")]
        public string AgencyName { get; set; }
        [JsonProperty("agencyid")]
        public int AgencyId { get; set; }

        public List<Months> listmonth { get; set; }
        
        public class Months
        {
            [JsonProperty("month")]
            public string Month { get; set; }
            [JsonProperty("saleactivitytypeidlist")]

            public List<int> SaleActivityTypeIdList { get; set; }
        }
   
    }
}
