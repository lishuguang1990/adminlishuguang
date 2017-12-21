using MallWCF.DBHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [PrimaryKey("PredictSettingId")]
    public  class PredicSetting
    {
        public int PredictSettingId { get; set; }

        public int SettingType { get; set; }

        public string FactorySation { get; set; }

        public string Signal { get; set; }

        public string ScaleDetial { get; set; }


    }
}
