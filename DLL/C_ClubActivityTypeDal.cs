using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public  class C_ClubActivityTypeDal: RepositoryFactory<C_ClubActivityType>
    {
        private static C_ClubActivityTypeDal _instance;
        private static object _object = new Object();
        public static C_ClubActivityTypeDal GetInstance()
        {
            if (_instance == null)
            {
                lock (_object)
                {
                    if (_instance == null)
                    {
                        _instance = new C_ClubActivityTypeDal();
                    }
                }
            }
            return _instance;
        }
        public int Add(C_ClubActivityType model)
        {
            return Repository().Insert(model);
        }
        public int Update(C_ClubActivityType model)
        {
            return Repository().Update(model);
        }
        public int Del(int id)
        {
            return Repository().Delete(id);
        }
        public List<C_ClubActivityType> GetList()
        {
            return Repository().FindList(" and isDelete=0 order by SortCode");
        }
        public C_ClubActivityType GetModel(int id)
        {
            return Repository().FindEntity(id);
        }
        public int DelList(string idList)
        {
            return Repository().Delete(idList.Split(','));
        }
        public int UpdateAll(string idList)
        {
            StringBuilder sb = new StringBuilder("update C_ClubActivityType set IsDelete=1 where ClubActivityTypeId in (" + idList + ")");
            return Repository().ExecuteBySql(sb);
        }
    }
}
