using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public  class C_ClubActivityInfoDal : RepositoryFactory<C_ClubActivityInfo>
    {
        private static C_ClubActivityInfoDal _instance;
        private static object _object = new Object();
        public static C_ClubActivityInfoDal GetInstance()
        {
            if (_instance == null)
            {
                lock (_object)
                {
                    if (_instance == null)
                    {
                        _instance = new C_ClubActivityInfoDal();
                    }
                }
            }
            return _instance;
        }
        public int Add(C_ClubActivityInfo model)
        {
            return Repository().Insert(model);
        }
        public int Update(C_ClubActivityInfo model)
        {
            return Repository().Update(model);
        }
        public int Del(int id)
        {
            return Repository().Delete(id);
        }
        public List<C_ClubActivityInfo> GetList()
        {
            return Repository().FindList(" and isDelete=0 order by SortCode");
        }
        public C_ClubActivityInfo GetModel(int id)
        {
            return Repository().FindEntity(id);
        }
        public int DelList(string idList)
        {
            return Repository().Delete(idList.Split(','));
        }
        public int UpdateAll(string idList)
        {
            StringBuilder sb = new StringBuilder("update C_ClubActivityInfo set IsDelete=1 where ClubActivityInfoId in (" + idList + ")");
            return Repository().ExecuteBySql(sb);
        }
    }
}
