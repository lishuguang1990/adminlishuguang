using DAL;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class ModuleOperateBll
    {
        public int ModuleOperateAdd(ModuleOperate model)
        {
            return ModuleOperateDal.GetInstance().ModuleOperateAdd(model);
        }
        public List<ModuleOperate> GetModuleOperateListByModuleId(int moduleid)
        {
            return ModuleOperateDal.GetInstance().GetModuleOperateListByModuleId(moduleid);
        }
        public List<ModuleOperate> GetList()
        {
            return ModuleOperateDal.GetInstance().GetList();
        }
        public ModuleOperate GetModel(int operateid)
        {
            return ModuleOperateDal.GetInstance().GetModel(operateid);
        }
        public int ModuleOperateEdit(ModuleOperate model)
        {
            return ModuleOperateDal.GetInstance().ModuleOperateEdit(model);
        }


    }
}
