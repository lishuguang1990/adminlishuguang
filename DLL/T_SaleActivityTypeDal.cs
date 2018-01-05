using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
  public   class T_SaleActivityTypeDal : RepositoryFactory<T_SaleActivityType>
    {
        private static T_SaleActivityTypeDal _instance;
        private static object _object = new Object();
        public static T_SaleActivityTypeDal GetInstance()
        {
            if (_instance == null)
            {
                lock (_object)
                {
                    if (_instance == null)
                    {
                        _instance = new T_SaleActivityTypeDal();
                    }
                }
            }
            return _instance;
        }
        public int Add(T_SaleActivityType model)
        {
            return Repository().Insert(model);
        }
        public  int Update(T_SaleActivityType model)
        {
            return Repository().Update(model);
        }
        public int Del(int id)
        {
            return Repository().Delete(id);
        }
        public T_SaleActivityType GetModel(int id)
        {
            return Repository().FindEntity(id);
        }
        public List<T_SaleActivityType> GetList()
        {
            return Repository().FindList(" group by SortCode");
        }

    }
}
