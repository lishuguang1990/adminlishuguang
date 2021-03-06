﻿using MallWCF.DBHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Model
{
    [PrimaryKey("ActivitAreaId")]
    public  class T_ActivityArea
    {
        public int ActivitAreaId { get; set;}

        public string ActivityAreaName { get; set; }

        public DateTime CreateTime { get; set; }

        public int CreateUserId { get; set; }

        public int SortCode { get; set; } = 0;

         public int IsShow { get; set; }

        public string CreateUserName { get; set; }

        public int IsDelete { get; set; } = 0;
    }
}
