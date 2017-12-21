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
  public class RoleBll
    {
        SysLogBll sysLogBll = new SysLogBll();
        public List<Role> GetRoleList()
        {
          return  RoleDal.GetInstance().GetRoleList();
        }
        public int RoleAdd(Role model)
        {
            model.ModifyUserId = ManageProvider.Provider.Current().UserId;
            model.ModifyUserName = ManageProvider.Provider.Current().Account;
            model.ModifyDate = DateTime.Now;
          
            if (model.RoleId == 0)
            {
                model.CreateUserId = ManageProvider.Provider.Current().UserId;
                model.CreateUserName = ManageProvider.Provider.Current().Account;
                model.CreateTime = DateTime.Now;

                int newid= RoleDal.GetInstance().RoleAdd(model);

                if (newid > 0)
                {
                    model.RoleId = newid;
                    sysLogBll.WriteLog<Role>(model, OperationType.Add, (int)LogSatus.Success, "角色添加");

                }
                else
                {
                    sysLogBll.WriteLog<Role>(model, OperationType.Add, (int)LogSatus.fail, "角色添加");
                }
                return newid;

            }
            else
            {

                Role OldRole = RoleDal.GetInstance().GetModel(model.RoleId);
                model.CreateTime = OldRole.CreateTime;
                int newid= RoleDal.GetInstance().RoleEdit(model);
           
                if (newid > 0)
                {
                    sysLogBll.WriteLog<Role>(OldRole, model, OperationType.Update, (int)LogSatus.Success, "角色修改");

                }
                else
                {
                    sysLogBll.WriteLog<Role>(OldRole,model, OperationType.Update, (int)LogSatus.fail, "角色修改");
                }
                return newid;
            }
            
        }
        public Role GetModel(int roleId)
        {
            return RoleDal.GetInstance().GetModel(roleId);
        }
        //通过角色获取用列表
        public string GetRoleUserByRoleId(int roleid)
        {
            IDatabase database = DataFactory.Database();
           var ds=  database.FindDataSetBySql("select Account from BaseUser where userId in  (select UserId from UserRole where RoleId=" + roleid + ")");
            StringBuilder sbUserName = new StringBuilder();
            if (ds.Tables[0].Rows.Count == 0)
            {
                return "";
            }
            else
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    sbUserName.Append(ds.Tables[0].Rows[i]["Account"].ToString() + ",");
                }
                return sbUserName.ToString().Substring(0, sbUserName.ToString().Length - 1);
            }
        
        }
        public Role GetModelByUserId(int UserId)
        {
            IDatabase database = DataFactory.Database();
          return  database.FindEntityBySql<Role>("select top 1 * from Role where RoleId in (select RoleId from  UserRole where UserId="+ UserId+")");
        }

    }
}
