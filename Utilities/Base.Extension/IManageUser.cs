using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace LeaRun.Utilities
{
    /// <summary>
    /// 管理用户接口
    /// </summary>
    public class IManageUser
    {
        public int UserId { get; set; }

        public string Account { get; set; }

        public string Code { get; set; }

        //public string RealName { get; set; }


        //public string Mobile { get; set; }
        //public string Telephone { get; set; }

          public string IPAddress { get; set; }

        public string IPAddressName { get; set; }

        public int RoleId { get; set; }

        public string RoleName { get; set; }



    }
}
