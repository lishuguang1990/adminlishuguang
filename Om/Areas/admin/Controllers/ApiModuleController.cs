using AutoMapper;
using BLL;
using LeaRun.Utilities;
using Model;
using Model.ModelView;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Om.Areas.admin.Controllers
{
    [RoutePrefix("api/ApiModule")]
    [Route("{action}")]
    public class ApiModuleController : ApiController
    {
        ModuleBll mduleBll = new ModuleBll();
        ModuleOperateBll ModuleOperateBll = new ModuleOperateBll();
        public Dictionary<string, object> ModuleAdd(Module model)
        {
            model.CreateTime = DateTime.Now;
            model.CreateUserId = ManageProvider.Provider.Current().UserId;
            if (model.ModuleId == 0)
            {
                int newid = mduleBll.ModuleAdd(model);
                if (newid > 0)
                {
                    List<ModuleOperate> list = new List<ModuleOperate>();
                    var operate = new ModuleOperate();
                    operate.CreateTime = model.CreateTime;
                    operate.CreateUserId = model.CreateUserId;
                    operate.CreateUserName = ManageProvider.Provider.Current().Account;
                    operate.ModuleId = newid;
                    operate.ModuleOperateName = "添加";
                    operate.JsEvent = "btn_add()";
                    operate.Sort = 1;
                    operate.Icon = "&#xe600";
                    operate.Enabled = 1;
                    list.Add(operate);
                    var operate1 = new ModuleOperate();
                    operate1.CreateTime = model.CreateTime;
                    operate1.CreateUserId = model.CreateUserId;
                    operate1.CreateUserName = ManageProvider.Provider.Current().Account;
                    operate1.ModuleId = newid;
                    operate1.ModuleOperateName = "编辑";
                    operate1.JsEvent = "btn_edit()";
                    operate1.Sort = 1;
                    operate1.Icon = "&#xe60c";
                    operate1.Enabled = 1;
                    list.Add(operate1);
                    var operate2 = new ModuleOperate();
                    operate2.CreateUserName = ManageProvider.Provider.Current().Account;
                    operate2.CreateTime = model.CreateTime;
                    operate2.CreateUserId = model.CreateUserId;
                    operate2.ModuleId = newid;
                    operate2.ModuleOperateName = "删除";
                    operate2.JsEvent = "btn_del()";
                    operate2.Sort = 1;
                    operate2.Icon = "&#xe6e2";
                    operate2.Enabled = 1;
                    list.Add(operate2);
                    ModuleOperateBll.CreateOperateAfterModuleAdd(list);

                    return new Dictionary<string, object>
                       {
                          { "code","1"}
                      };
                }
                else
                {
                    return new Dictionary<string, object>
                      {
                          { "code","0"},
                          { "msg","添加失败"}
                      };
                }
            }
            else
            {

                if (model.Icon == null)
                    model.Icon = "";

                if (mduleBll.ModuleEdit(model) > 0)
                {
                    return new Dictionary<string, object>
                       {
                          { "code","1"}
                      };
                }
                else
                {
                    return new Dictionary<string, object>
                       {
                            { "code","0"},
                            { "msg","修改失败"}
                      };
                }
            }
       
        }
        [HttpPost]
        //获取模块的列表
        public Dictionary<string, object> GetModelList()
        {
            ModuleBll Bll = new ModuleBll();
            List<Module> list = Bll.GetModuleList();
            var listmodel = Mapper.Map<List<ModuleViewModel>>(list);
            return new Dictionary<string, object>
            {
                { "code",1},
                { "list",listmodel}
            };
        }
    }
}
