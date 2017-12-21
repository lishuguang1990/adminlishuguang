using BLL.Job;
using DAL;
using MallWCF.DBHelper;
using Model;
using Quartz;
using Quartz.Impl;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
   public  class PredicSettingBll
    {

        public int PredicSettingAdd(PredicSetting model)
        {
            return PredicSettingDal.GetInstance().PredicSettingAdd(model);
        }
        public int PredicSettingEdit(PredicSetting model)
        {
            return PredicSettingDal.GetInstance().PredicSettingEdit(model);
        }
        public PredicSetting GetModel(int id)
        {
            return PredicSettingDal.GetInstance().GetModel(id);
        }
        public int PredicSettingDel(int id)
        {
            return PredicSettingDal.GetInstance().PredicSettingDel(id);
        }

        public bool IsExits(string factorysation,string signal,ref string ScaleDetial)
        {
           
            IDatabase database = DataFactory.Database();
           var ds= database.FindDataSetBySql("select top 1  PredictSettingId,ScaleDetial from PredicSetting where FactorySation='" + factorysation + "' and Signal='" + signal + "'");
            if (ds.Tables[0].Rows.Count > 0)
            {
                ScaleDetial = ds.Tables[0].Rows[0]["ScaleDetial"].ToString();
                return true;
            }
            else
            {
                ScaleDetial = "";
                return false;
            }
        }


        public void ZiDongDaoRu(string corn)
        {
            IScheduler scheduler = StdSchedulerFactory.GetDefaultScheduler();
            scheduler.Start();
            var exists = scheduler.CheckExists(new TriggerKey("trigger", "triggers"));
            if (exists)
            {
                var trigger = TriggerBuilder.Create().ForJob("job", "jobs")
                      .WithIdentity("trigger", "triggers")
                      .WithCronSchedule(corn)
                      .Build();
                scheduler.RescheduleJob(new TriggerKey("trigger", "triggers"), trigger);
            }
            else
            {
                var job = JobBuilder.Create<DaoRuJob>()
            .WithIdentity("job", "jobs")
            .Build();
                var trigger = TriggerBuilder.Create().WithCronSchedule(corn)
                    .WithIdentity("trigger", "triggers")
                    .Build();
                scheduler.ScheduleJob(job, trigger);
            }
        
        }

    }
}
