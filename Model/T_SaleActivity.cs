using MallWCF.DBHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [PrimaryKey("SaleActivityId")]
    public   class T_SaleActivity
    {
        public int SaleActivityId { get; set; }

        public int AgencyId { get; set; }
        public int AreaId { get; set; }

        public DateTime ActivityDate { get; set; } = DateTime.Now;

        public int SaleActivityTypeId { get; set; }

        public int PassengerFlow { get; set; }
        public int LatentPassengerFlow { get; set;}

        public int CarOwner { get; set; }

        public int OrderQuantity { get; set; }

        public decimal PrimeCost { get; set; }

        public int LaterOrderQuantity { get; set; }

        public string PublishWay { get; set; }

        public DateTime CreateTime { get; set; }

        public int CreateUserId { get; set; }

        public string ActivityName { get; set; }

        public int IsShow { get; set; }

        public int IsDelete { get; set; } = 0;

        public string CreateUserName { get; set;}

    }
}
