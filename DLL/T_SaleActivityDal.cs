using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
   public   class T_SaleActivityDal:RepositoryFactory<T_SaleActivity>
    {
            private static T_SaleActivityDal _instance;
            private static object _object = new Object();
            public static T_SaleActivityDal GetInstance()
            {
                if (_instance == null)
                {
                    lock (_object)
                    {
                        if (_instance == null)
                        {
                            _instance = new T_SaleActivityDal();
                        }
                    }
                }
                return _instance;
            }
            public int Add(T_SaleActivity model)
            {
                return Repository().Insert(model);
            }
            public int Update(T_SaleActivity model)
            {
                return Repository().Update(model);
            }
            public int Del(int id)
            {
                return Repository().Delete(id);
            }
            public List<T_SaleActivity> GetList()
            {
                return Repository().FindList(" and isDelete=0");
            }
            public T_SaleActivity GetModel(int id)
            {
                return Repository().FindEntity(id);
            }
            public int DelList(string idList)
            {
                return Repository().Delete(idList.Split(','));
            }
            public int UpdateAll(string idList)
            {
                StringBuilder sb = new StringBuilder("update T_SaleActivity set IsDelete=1 where SaleActivityId in (" + idList + ")");
                return Repository().ExecuteBySql(sb);
            }
        }
}
