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
    public class ApiModuleController : ApiController
    {
        ModuleBll mduleBll = new ModuleBll();
        public Dictionary<string, object> ModuleAdd(Module model)
        {
            model.CreateTime = DateTime.Now;
            model.CreateUserId = ManageProvider.Provider.Current().UserId;
            if (model.ModuleId == 0)
            {
                if (mduleBll.ModuleAdd(model) > 0)
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
                          { "msg","添加失败"}
                      };
                }
            }
            else
            {
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
