using BLL;
using LeaRun.Utilities;
using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.Http;

namespace Om.Controllers
{
    public class ApiCauseController : ApiController

    {

  
         [HttpPost]
        public Dictionary<string, object> CauseAdd(Sys_CauseSuggestion model)

        {
            Sys_CauseSuggestionBll bll = new Sys_CauseSuggestionBll();
            if (model.CauseId > 0)
            {
                var model1 = bll.GetModel(model.CauseId);
                model1.CauseContent = model.CauseContent;
                model1.RelatedContent = model.RelatedContent;
                model1.ParentId = model.ParentId;

                if (model.SuggestionContent == null)
                {
                    model1.SuggestionContent = "";
                }
                else
                {
                    model1.SuggestionContent= model.SuggestionContent;
                }
               

                if (model.ParentId == 0)
                {
                    model1.Code = "." + model.CauseId.ToString() + ".";

                }
                else
                {
                    model1.Code = "."+model.ParentId +"." + model.CauseId.ToString() + ".";
                }
                if (bll.Sys_CauseSuggestionEdit(model1) > 0)
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
                          { "code","0"}
                      };
                }
            }
            else
            {
             
                model.CreateTime = DateTime.Now;
                model.CreateUserId = ManageProvider.Provider.Current().UserId;
                model.CreateUserName = ManageProvider.Provider.Current().Account;
                if (model.SuggestionContent == null)
                {
                    model.SuggestionContent = "";
                }
                if (model.RelatedContent == null)
                {
                    model.RelatedContent = "";
                }
                model.CauseCode = "";
               
                model.Sort = 0;
                if (bll.CauseAdd(model) > 0)
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
                          { "code","0"}
                      };
                }
            }
           
        }

        [HttpPost]
        public Dictionary<string, object> CauseList(JqGridParam jqgridparam)
        {
            var type = HttpContext.Current.Request.Form["type"].ToString();
            var key = HttpContext.Current.Request.Form["key"].ToString();
            IDatabase database = DataFactory.Database();
            IRepository<Module> re = new Repository<Module>();
            DataTable data = new DataTable();
            string strwhere = " 1=1 ";
            if (!string.IsNullOrEmpty(type))
            {
                strwhere += " and ParentId=" + type;
            }
            if (!string.IsNullOrEmpty(key))
            {
                strwhere += " and (CauseContent like '%"+key+ "%' or SuggestionContent like '%"+key+"%')";

            }
            data = re.FindTablePageBySql("select CauseId,ParentId,Code,[CauseContent],SuggestionContent,CreateTime,[CreateUserId],CreateUserName ,Sort,RelatedContent from Sys_CauseSuggestion ", ref jqgridparam);
            return new Dictionary<string, object>
            {
                { "code",1},
                { "total",jqgridparam.total},
                { "page",jqgridparam.page},
                { "records",jqgridparam.records},
                { "rows",data},
            };
        }
        /// <summary>
        /// 原因删除
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public Dictionary<string, object> CauseDel()
        {
            Sys_CauseSuggestionBll bll = new Sys_CauseSuggestionBll();
            var causeid = HttpContext.Current.Request.Form["causeid"].ToString();
            List<Sys_CauseSuggestion> list = bll.GetModelList(causeid,1);
            StringBuilder sb = new StringBuilder();
            foreach (var item in list)
            {
                if (item.ParentId > 0)
                {
                    bll.CauseDel(item.CauseId);
                }
                else
                {
                    if (bll.GetModelList(item.CauseId.ToString(),2).Count>0)
                    {
                        sb.Append(item.CauseId.ToString());
                    }
                    else
                    {
                        bll.CauseDel(item.CauseId);
                    }
                   
                }

            }
            if (sb.ToString() == "")
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
                     { "msg","编号为"+sb.ToString()+"的数据不能删除若要删除请先删除此数据关联的原因"}
                 };
            }



        }


    }


}
