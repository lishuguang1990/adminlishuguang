using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model.ModelView
{
  public  class SettingModel
    {
        public string selecttimes { get; set; }
         public int yujingtype { get; set; }
        public string weekendbili { get; set; }
         public int mothtimes { get; set; }
        //饼状图显示的数量
        public int showcount { get; set; }

        public string daorutime { get; set; }
        public string daorudir { get; set; }

        public string NextDoTime { get; set; }

        public string daorunowdate { get; set; }
    }
}

