using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
   public  class ModuleOperateDal: RepositoryFactory<ModuleOperate>
    {
        private static ModuleOperateDal _instance;
        private static object _object = new Object();
        public static ModuleOperateDal GetInstance()
        {
            if (_instance == null)
            {
                lock (_object)
                {
                    if (_instance == null)
                    {
                        _instance = new ModuleOperateDal();
                    }
                }
            }
            return _instance;
        }
        private ModuleOperateDal()
        {

        }
        public int ModuleOperateAdd(ModuleOperate model)
        {
            return Repository().Insert(model);
        }
        public List<ModuleOperate> GetModuleOperateListByModuleId(int moduleid)
        {
            return Repository().FindList("ModuleId", moduleid.ToString());
        }
        public List<ModuleOperate> GetList()
        {
            return Repository().FindList();
        }

        public ModuleOperate GetModel(int operateid)
        {
            return Repository().FindEntity(operateid);
        }
        public int ModuleOperateEdit(ModuleOperate model)
        {
            return Repository().Update(model);
        }
    }
}
