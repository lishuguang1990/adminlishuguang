using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
   public  class ModuleDal: RepositoryFactory<Module>
    {
        private static ModuleDal _instance;
        private static object _object = new Object();
        public static ModuleDal GetInstance()
        {
            if (_instance == null)
            {
                lock (_object)
                {
                    if (_instance == null)
                    {
                        _instance = new ModuleDal();
                    }
                }
            }
            return _instance;
        }
        private ModuleDal()
        {
            
        }
        public int ModuleAdd(Module model)
        {
            return Repository().Insert(model);
        }
        public List<Module> GetModuleList()
        {
            return Repository().FindList();
        }

        public Module GetModel(int moduleid)
        {
            return Repository().FindEntity(moduleid);
        }
        public int ModuleEdit(Module model)
        {
            return Repository().Update(model);
        }
    }
}
