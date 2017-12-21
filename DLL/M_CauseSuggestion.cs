using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace DAL
{



    public class Sys_CauseSuggestionDal : RepositoryFactory<Sys_CauseSuggestion>
    {
        private static Sys_CauseSuggestionDal _instance;
        private static object _object = new Object();
        public static Sys_CauseSuggestionDal GetInstance()
        {
            if (_instance == null)
            {
                lock (_object)
                {
                    if (_instance == null)
                    {
                        _instance = new Sys_CauseSuggestionDal();
                    }
                }
            }
            return _instance;
        }
        private Sys_CauseSuggestionDal()
        {

        }
        public int CauseAdd(Sys_CauseSuggestion model)
        {
            SqlParameter[] par =
             { new SqlParameter("@CauseContent",SqlDbType.NVarChar),
               new SqlParameter("@ParentId",SqlDbType.Int),
               new SqlParameter("@Sort",SqlDbType.Int),
               new SqlParameter("@CauseCode",SqlDbType.NVarChar),
               new SqlParameter("@SuggestionContent",SqlDbType.NVarChar),
               new SqlParameter ("@RelatedContent",SqlDbType.NVarChar),
               new SqlParameter("@CreateTime",SqlDbType.DateTime),
               new SqlParameter("@CreateUserId",SqlDbType.Int),
               new SqlParameter("@CreateUserName",SqlDbType.NVarChar)
            };
            par[0].Value = model.CauseContent;
            par[1].Value = model.ParentId;
            par[2].Value = model.Sort;
            par[3].Value = model.CauseCode;
            par[4].Value = model.SuggestionContent;
            par[5].Value = model.RelatedContent;
            par[6].Value = model.CreateTime;
            par[7].Value = model.CreateUserId;
            par[8].Value = model.CreateUserName;
            return Repository().ExecuteByProc("Sys_CauseSuggestionadd", par);
        }

        public List<Sys_CauseSuggestion> GetList()
        {
            return Repository().FindListBySql("select CauseId,CauseContent,CauseLevel from  Sys_CauseSuggestion where ParentId=0   ");
        }

        public Sys_CauseSuggestion GetModel(int id)
        {
            return Repository().FindEntity(id);
        }
        public int Sys_CauseSuggestionEdit(Sys_CauseSuggestion model)
        {
            return Repository().Update(model);
        }
        public int CauseDel(int id)
        {
            return Repository().Delete(id);
        }
        //获取要删除的集合
        public List<Sys_CauseSuggestion> GetModelList(string ids,int type)
        {
            if (type == 1)
            {
                return Repository().FindListBySql("select CauseId,ParentId from Sys_CauseSuggestion where CauseId in (" + ids + ") ");

            }
            else
            {
                return Repository().FindListBySql("select CauseId,ParentId from Sys_CauseSuggestion where ParentId ="+ ids);
            }
        }

       

    }
}
