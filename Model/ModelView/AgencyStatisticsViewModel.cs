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
        public string agencyname { get; set; }

        public class Months
        {
            [JsonProperty("month")]
            public string Month { get; set; }
        }
        public class MonthtType
        {
            public int TypeId { get; set; }
        }
    }
}
