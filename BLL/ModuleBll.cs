using DAL;
using LeaRun.Utilities;
using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utilities;

namespace BLL
{
   public  class ModuleBll
    {
        public int ModuleAdd(Module model)
        {
            return ModuleDal.GetInstance().ModuleAdd(model);
        }
        public List<Module> GetModuleList()
        {
            return ModuleDal.GetInstance().GetModuleList();
        }
        public List<Module> GetModuleListByUserId()
        {
            int userid = ManageProvider.Provider.Current().UserId;
           return  DataFactory.Database().FindListBySql<Module>("select ModuleId,ModuleName,ControllerName,ParentId ,ActionName from Module where IsShow=1 and   ModuleId in (select ModuleId from ModuleRole where RoleId in (select RoleId from UserRole where UserId=" + userid + "  )   )    order by Sort");

        }
        public bool ActionAuthorize(string controllerName,string action,int userId,out string moduleId )
        {
            Module model = DataFactory.Database().FindEntityByWhere<Module>(" and ActionName='" + action + "' and ControllerName='" + controllerName+"'");
            List<ModuleRole> listData = new List<ModuleRole>();
            object ActionAuthorize_List = DataCache.Get("ActionAuthorizeList_" + userId);
            if (ActionAuthorize_List == null)
            {
                listData = DataFactory.Database().FindListBySql<ModuleRole>("Select ModuleId  from ModuleRole where RoleId in (select RoleId from  UserRole where UserId=" + userId+")");
                DataCache.Insert("ActionAuthorizeList_" + userId, listData);
            }
            else
            {
                listData = (List<ModuleRole>)ActionAuthorize_List;
            }
            listData = (from entity in listData where entity.ModuleId == model.ModuleId select entity).ToList();
            int count = listData.Count;
            if (count > 0)
            {
                moduleId = model.ModuleId.ToString();
                return true;
            }
            else
            {
                moduleId = model.ModuleId.ToString();
                return false;
            }

        }

        public Module GetModel(int moduleid)
        {
            return ModuleDal.GetInstance().GetModel(moduleid);
        }
        public int ModuleEdit(Module model)
        {
            return ModuleDal.GetInstance().ModuleEdit(model);
        }

    }
}
