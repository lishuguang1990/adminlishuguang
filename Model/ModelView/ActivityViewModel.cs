using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.ModelView
{
   public  class ActivityViewModel
    {
        public int SaleActivityId { get; set; }

        public string  AgencyName { get; set; }
        public string AreaName { get; set; }

        public DateTime ActivityDate { get; set; }

        public string SaleActivityTypeName { get; set; }

        public int PassengerFlow { get; set; }
        public int LatentPassengerFlow { get; set; }

        public int CarOwner { get; set; }

        public int OrderQuantity { get; set; }

        public decimal PrimeCost { get; set; }

        public int LaterOrderQuantity { get; set; }

        public string PublishWay { get; set; }

        public DateTime CreateTime { get; set; }

        public string ActivityName { get; set; }

        public string  IsShow { get; set; }
    }
}
