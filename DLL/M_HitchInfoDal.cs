using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
   public  class M_HitchInfoDal: RepositoryFactory<M_HitchInfo>
    {
        private static M_HitchInfoDal _instance;
        private static object _object = new Object();
        public static M_HitchInfoDal GetInstance()
        {
            if (_instance == null)
            {
                lock (_object)
                {
                    if (_instance == null)
                    {
                        _instance = new M_HitchInfoDal();
                    }
                }
            }
            return _instance;
        }
        private M_HitchInfoDal()
        {

        }

        public int M_HitchInfoAdd(M_HitchInfo model)
        {
            return Repository().Insert(model);
        }
        //获取故障列表
        public DataTable GetPageList(ref JqGridParam jqgridparam)
        {
        
            StringBuilder strSql = new StringBuilder();
            List<DbParameter> parameter = new List<DbParameter>();
            strSql.Append(@"select HitchId,AreaName,FactorySation, Signal,HappenTimes,SignalType,HappenTimes1,CreateTime,CreateUserId,CreateUserName from  M_HitchInfo");
            return Repository().FindTablePageBySql(strSql.ToString(), ref jqgridparam);
        }

    }
}
