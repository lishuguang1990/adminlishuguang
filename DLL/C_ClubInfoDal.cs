using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
   public  class C_ClubInfoDal : RepositoryFactory<C_ClubInfo>
    {
        private static C_ClubInfoDal _instance;
        private static object _object = new Object();
        public static C_ClubInfoDal GetInstance()
        {
            if (_instance == null)
            {
                lock (_object)
                {
                    if (_instance == null)
                    {
                        _instance = new C_ClubInfoDal();
                    }
                }
            }
            return _instance;
        }
        public int Add(C_ClubInfo model)
        {
            return Repository().Insert(model);
        }
        public int Update(C_ClubInfo model)
        {
            return Repository().Update(model);
        }
        public int Del(int id)
        {
            return Repository().Delete(id);
        }
        public List<C_ClubInfo> GetList()
        {
            return Repository().FindList(" and isDelete=0");
        }
        public C_ClubInfo GetModel(int id)
        {
            return Repository().FindEntity(id);
        }
        public int DelList(string idList)
        {
            return Repository().Delete(idList.Split(','));
        }
        public int UpdateAll(string idList)
        {
            StringBuilder sb = new StringBuilder("update C_ClubInfo set IsDelete=1 where ClubInfoId in (" + idList + ")");
            return Repository().ExecuteBySql(sb);
        }
        public C_ClubInfo GetModel(string date)
        {
            return Repository().FindEntityByWhere(" and  DATEDIFF(month,ClubDate,'"+ date + "')=0 and IsDelete=0");
        }

    }
}
