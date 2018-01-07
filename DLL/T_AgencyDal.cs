using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
   public  class T_AgencyDal : RepositoryFactory<T_Agency>
    {
        private static T_AgencyDal _instance;
        private static object _object = new Object();
        public static T_AgencyDal GetInstance()
        {
            if (_instance == null)
            {
                lock (_object)
                {
                    if (_instance == null)
                    {
                        _instance = new T_AgencyDal();
                    }
                }
            }
            return _instance;
        }
        public int Add(T_Agency model)
        {
            return Repository().Insert(model);
        }
        public int Update(T_Agency model)
        {
            return Repository().Update(model);
        }
        public int Del(int id)
        {
            return Repository().Delete(id);
        }
        public List<T_Agency> GetList()
        {
            return Repository().FindList(" and isDelete=0 order by SortCode");
        }
        public T_Agency GetModel(int id)
        {
            return Repository().FindEntity(id);
        }
        public int DelList(string idList)
        {
            return Repository().Delete(idList.Split(','));
        }
        public int UpdateAll(string idList)
        {
            StringBuilder sb = new StringBuilder("update T_Agency set IsDelete=1 where AgencyId in (" + idList + ")");
            return Repository().ExecuteBySql(sb);
        }
    }
}
