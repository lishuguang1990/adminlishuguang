using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
   public  class T_ActivityAreaDal : RepositoryFactory<T_ActivityArea>
    {
        private static T_ActivityAreaDal _instance;
        private static object _object = new Object();
        public static T_ActivityAreaDal GetInstance()
        {
            if (_instance == null)
            {
                lock (_object)
                {
                    if (_instance == null)
                    {
                        _instance = new T_ActivityAreaDal();
                    }
                }
            }
            return _instance;
        }
        public int Add(T_ActivityArea model)
        {
            return Repository().Insert(model);
        }
        public int Update(T_ActivityArea model)
        {
            return Repository().Update(model);
        }
        public int Del(int id)
        {
            return Repository().Delete(id);
        }
        public List<T_ActivityArea> GetList()
        {
            return Repository().FindList(" and isDelete=0 order by SortCode");
        }
        public T_ActivityArea GetModel(int id)
        {
            return Repository().FindEntity(id);
        }
        public int DelList(string idList)
        {
           return  Repository().Delete(idList.Split(','));
        }
        public int UpdateAll(string idList)
        {
            StringBuilder sb = new StringBuilder("update T_ActivityArea set IsDelete=1 where ActivitAreaId in (" + idList + ")");
            return Repository().ExecuteBySql(sb);
        }
    }
}
