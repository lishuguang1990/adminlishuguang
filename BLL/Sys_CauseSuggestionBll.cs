using DAL;
using DLL;
using MallWCF.DBHelper;
using Model;
using Model.ModelView;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
  public   class Sys_CauseSuggestionBll
    {
        public int CauseAdd(Sys_CauseSuggestion model)
        {
            return Sys_CauseSuggestionDal.GetInstance().CauseAdd(model);
        }
        public List<Sys_CauseSuggestion> GetList()
        {
            return Sys_CauseSuggestionDal.GetInstance().GetList();
        }
        public Sys_CauseSuggestion GetModel(int id)
        {
            return Sys_CauseSuggestionDal.GetInstance().GetModel(id);
        }
        public int Sys_CauseSuggestionEdit(Sys_CauseSuggestion model)
        {
            return Sys_CauseSuggestionDal.GetInstance().Sys_CauseSuggestionEdit(model);
        }
        public int CauseDel(int id)
        {
            return Sys_CauseSuggestionDal.GetInstance().CauseDel(id);
        }
        public List<Sys_CauseSuggestion> GetModelList(string ids,int type)
        {
            return Sys_CauseSuggestionDal.GetInstance().GetModelList(ids,type);
        }
     
        //判断信息是获取列表
        public List<M_SolutionView> GetCauseSuggestionListByContent(string content,string FactorySation,ref string contentdetial)
        {
            int inta = 0;
            string content1 = "";
            IDatabase database = DataFactory.Database();
            StringBuilder sb = new StringBuilder();
            List<M_SolutionView> modellist = new List<M_SolutionView>();
            List<Sys_CauseSuggestion> list = database.FindListBySql<Sys_CauseSuggestion>("select [CauseId], CauseContent from Sys_CauseSuggestion where parentid=0");
            var model1=list.FirstOrDefault(a => content.Contains(a.CauseContent));
          
         //   DataSet ds1 = database.FindDataSetBySql("select top 1 CauseId,CauseContent from Sys_CauseSuggestion where  ParentId=0 and  CauseContent like '%" + content + "%'");
            if (model1!=null)
            {
                DataSet ds = database.FindDataSetBySql("select CauseId,CauseContent,SuggestionContent,RelatedContent from Sys_CauseSuggestion where ParentId=" + model1.CauseId);
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    sb.Append(ds.Tables[0].Rows[i]["CauseId"].ToString()+",");
                }
                string ids = sb.ToString().Substring(0, sb.ToString().Length - 1);
                //取出当前信息发生的所有次数
                List<M_Solution> listall = database.FindListBySql<M_Solution>("select sum(HappenTimes)  as HappenTimes,[CauseId],sum(EventTimes) as EventTimes from M_Solution where CauseId in (" + ids + ")  group by CauseId");
                List<M_Solution> listnow = database.FindListBySql<M_Solution>("select sum(HappenTimes)  as HappenTimes,[CauseId],sum(EventTimes) as  EventTimes from M_Solution where CauseId in (" + ids + ") and FactorySation='" + FactorySation + "' and  Signal='" + content + "'   group by CauseId");
                int maxall = 0;
                int maxnow = 0;
                int eventmaxtall = 0;
                int eventmaxnow = 0;
                if (listall.Count > 0)
                {
                    maxall = listall.Max(a => a.HappenTimes);
                    eventmaxtall = listall.Max(a => a.EventTimes);

                }
                if (listnow.Count > 0)
                {
                    maxnow = listnow.Max(a => a.HappenTimes);
                    eventmaxnow = listnow.Max(a => a.EventTimes);

                }

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    M_SolutionView model = new M_SolutionView();
                    model.CauseId = int.Parse(ds.Tables[0].Rows[i]["CauseId"].ToString());
                    model.SuggestionContent = ds.Tables[0].Rows[i]["SuggestionContent"].ToString();
                    model.CauseContent = ds.Tables[0].Rows[i]["CauseContent"].ToString();
                    model.RelatedContent = ds.Tables[0].Rows[i]["RelatedContent"].ToString();
                    var nowmodel = listnow.FirstOrDefault(a => a.CauseId == model.CauseId);
                    if (nowmodel == null)
                    {
                        model.ThisHappensTimes = 0;
                        model.ThisEventTimes = 0;
                    }
                    else
                    {
                        model.ThisHappensTimes = nowmodel.HappenTimes;
                        model.ThisEventTimes = nowmodel.EventTimes; ;
                    }
                    var allmodel = listall.FirstOrDefault(a => a.CauseId == model.CauseId);
                    if (allmodel == null)
                    {
                        model.AllHappenSTimes = 0;
                        model.AllEventTimes = 0;
                    }
                    else
                    {
                        model.AllHappenSTimes = allmodel.HappenTimes;
                        model.AllEventTimes = allmodel.EventTimes;
                    }
                  
                    model.AllEventTimesMax = eventmaxtall;
                    model.ThisEventTimesMax = eventmaxnow;
                    model.AllHappenSTimesMax = maxall;
                    model.ThisHappensTimesMax = maxnow;
                    modellist.Add(model);
                }
                contentdetial = model1.CauseContent;
            }
            else
            {
                contentdetial = "";
            }
             
                return modellist;
                
            
        
        }   

    }
}
