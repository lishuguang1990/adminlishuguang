using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
   public  class RoleDal: RepositoryFactory<Role>
    {
        private static RoleDal _instance;
        private static object _object = new Object();
        public static RoleDal GetInstance()
        {
            if (_instance == null)
            {
                lock (_object)
                {
                    if (_instance == null)
                    {
                        _instance = new RoleDal();
                    }
                }
            }
            return _instance;
        }
        private RoleDal()
        {

        }

        public List<Role> GetRoleList()
        {
            return Repository().FindList();
        }
        public int RoleAdd(Role model)
        {
            return Repository().Insert(model);
        }

        public int RoleEdit(Role model)
        {
            return Repository().Update(model);
        }
        public Role GetModel(int roleId)
        {
            return Repository().FindEntity(roleId);
        }
    }
}
