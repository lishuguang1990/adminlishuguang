using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utilities
{
    public enum OperationType
    {
        /// <summary>
        /// 登陆
        /// </summary>
        Login = 0,
        /// <summary>
        /// 新增
        /// </summary>
        Add = 1,
        /// <summary>
        /// 修改
        /// </summary>
        Update = 2,
        /// <summary>
        /// 删除
        /// </summary>
        Delete = 3,
        /// <summary>
        /// 其他
        /// </summary>
        Other = 4,
        /// <summary>
        /// 访问
        /// </summary>
        Visit = 5,
        /// <summary>
        /// 离开
        /// </summary>
        Leave = 6,
        /// <summary>
        /// 查询
        /// </summary>
        Query = 7,
        /// <summary>
        /// 安全退出
        /// </summary>
        Exit = 8,
    }

    public enum LogSatus
    {
        //成功
         Success=0,
        //失败
        fail = 1,
        //异常
        Abnormal=2

    }
    public enum ModuleType
    {
      [Description("显示")]
        Show =1,
      [Description("隐藏")]
        Hide =0
    }
    /// <summary>
    /// 获取SelectListItem列表是否给个请选择
    /// </summary>
    public enum SelectListItemSelect
    {
         Ok=1,
         No=0
    }

    public enum yujingbilitype
    {
        [Description("每天均分")]
        每天均分 =0,
        [Description("周末工作日固定比例")]
        周末工作日固定比例 =1
    }



}
