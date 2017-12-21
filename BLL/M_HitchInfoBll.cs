using DAL;
using MallWCF.DBHelper;
using Model;
using Model.ModelView;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Reflection;
using System.Web;
using System.Xml;
using Quartz;
using Quartz.Impl;
using Quartz.Impl.Matchers;
using LeaRun.Utilities;

namespace BLL
{
  public   class M_HitchInfoBll
    {
        public int M_HitchInfoAdd(M_HitchInfo model)
        {
            return M_HitchInfoDal.GetInstance().M_HitchInfoAdd(model);
        }
        public DataTable GetPageList(ref JqGridParam jqgridparam)
        {
            return M_HitchInfoDal.GetInstance().GetPageList(ref jqgridparam);
        }
        //获取场站
        public List<string> GetFactorySationList()
        {
            IDatabase database = DataFactory.Database();
            var ds = database.FindDataSetBySql("SELECT [FactorySation]  FROM[ElectricPower].[dbo].[M_HitchInfo]   group by FactorySation  order by FactorySation");
            List<string> list = new List<string>();
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                list.Add(ds.Tables[0].Rows[i]["FactorySation"].ToString());
            }
            return list;
        }
        public SettingModel GetSettingModel()
        {
             
            SettingModel SettingModel1 = new SettingModel();
           // Type t = typeof(SettingModel);
            string path = HttpContext.Current.Server.MapPath("/App_Data/selfsetting.xml");
            XmlDocument xmldoc = new XmlDocument();
            xmldoc.Load(path);
           // PropertyInfo[] properties = t.GetProperties();
            SettingModel1.selecttimes = xmldoc.SelectSingleNode("root").SelectSingleNode("selecttimes").Attributes[0].Value;
            SettingModel1.mothtimes = int.Parse(xmldoc.SelectSingleNode("root").SelectSingleNode("mothtimes").Attributes[0].Value);
            SettingModel1.weekendbili = xmldoc.SelectSingleNode("root").SelectSingleNode("weekendbili").Attributes[0].Value;
            SettingModel1.showcount = int.Parse(xmldoc.SelectSingleNode("root").SelectSingleNode("showcount").Attributes[0].Value);
            SettingModel1.daorutime =xmldoc.SelectSingleNode("root").SelectSingleNode("daorutime").Attributes[0].Value;
            SettingModel1.daorudir = xmldoc.SelectSingleNode("root").SelectSingleNode("daorudir").Attributes[0].Value;
            SettingModel1.daorunowdate = xmldoc.SelectSingleNode("root").SelectSingleNode("daorunowdate").Attributes[0].Value;
            var scheduler = StdSchedulerFactory.GetDefaultScheduler();
            var triggerKeys = scheduler.GetTriggerKeys(GroupMatcher<TriggerKey>.AnyGroup());
            var trigger= scheduler.GetTrigger(new TriggerKey("trigger", "triggers"));
           //  && scheduler.GetTriggerState(new TriggerKey("trigger", "triggers")) == TriggerState.Normal
            if (trigger != null)
            {

                SettingModel1.NextDoTime = trigger.GetNextFireTimeUtc()?.LocalDateTime.ToString();

            }
           


            return SettingModel1;
        }
        public string GetSetting(string property)
        {
            string path = HttpContext.Current.Server.MapPath("/App_Data/selfsetting.xml");
            XmlDocument xmldoc = new XmlDocument();
            xmldoc.Load(path);
            return xmldoc.SelectSingleNode("root").SelectSingleNode(property).Attributes[0].Value;
        }

        //获取剩余的数量
        public static int GetRestCount(List<int> list, int index)
        {
            int sum = 0;
           
            for (int i = 0; i < list.Count; i++)
            {
                if (i < index)
                {
                    sum += list[i];
                }
                else {
                    break;
                }
               
            }
            return sum; 
        }
        public static int GetListSum(List<int> list)
        {
            int sum = 0;
            foreach (var item in list)
            {
                sum += item;
            }
            return sum;

        }
        public List<M_HitchInfoView> GetEveryDayYujiList(DateTime dt)
        {
            List<M_HitchInfoView> M_HitchInfoViewlist = new List<M_HitchInfoView>();
            IDatabase database = DataFactory.Database();
            var dsmonth = database.FindDataSetBySql("select sum(HappenTimes) as HappenTimes,FactorySation,Signal  FROM  M_HitchInfo WHERE    DATEDIFF(MONTH, CreateTime, '" + dt.ToString()+"') = 0 AND CreateTime < '"+ dt.ToString() + "' group by FactorySation,Signal");
            var dsPredicSetting = database.FindDataSetBySql("select FactorySation,Signal,ScaleDetial from  PredicSetting");
           // var 
            var ds = database.FindDataSetBySql("select FactorySation,Signal,sum(HappenTimes) as HappenTimes ,CreateTime from M_HitchInfo where  DATEDIFF(day,CreateTime,'" + dt + "')=0 group by CreateTime,[FactorySation], Signal");
            if (ds.Tables[0].Rows.Count > 0)
            {
               
                PredicSettingBll PredicSettingBll = new PredicSettingBll();
                string path = HttpContext.Current.Server.MapPath("/App_Data/selfsetting.xml");
                XmlDocument xmldoc = new XmlDocument();
                xmldoc.Load(path);
                int totalday = int.Parse(xmldoc.SelectSingleNode("root").SelectSingleNode("mothtimes").Attributes[0].Value);
                string bili = xmldoc.SelectSingleNode("root").SelectSingleNode("weekendbili").Attributes[0].Value;
                string[] arrbili = bili.Split(':');
                string createtime = dt.ToString();
                List<int> listdays = DateTimeHelper.GetMonthArr(DateTime.Parse(createtime));
                List<int> shijilistbili = new List<int>();
                for (int j = 0; j < listdays.Count; j++)
                {
                  
                    //工作日
                    if (listdays[j] == 0)
                    {
                        shijilistbili.Add(int.Parse(arrbili[1]));
                    }
                    else
                    {
                        shijilistbili.Add(int.Parse(arrbili[0]));
                    }
                }
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    string factorysation = ds.Tables[0].Rows[i]["FactorySation"].ToString();
                    string signal = ds.Tables[0].Rows[i]["Signal"].ToString();
                    int usedtimes = 0;
                    for (int z = 0; z < dsmonth.Tables[0].Rows.Count; z++)
                    {
                        if (factorysation == dsmonth.Tables[0].Rows[z]["FactorySation"].ToString()&& signal== dsmonth.Tables[0].Rows[z]["Signal"].ToString())
                        {
                            usedtimes = int.Parse(dsmonth.Tables[0].Rows[z]["HappenTimes"].ToString());
                              break;
                        }
                    }
              
                    M_HitchInfoView M_HitchInfoView = new M_HitchInfoView();
                  
                  

                    List<int> shijilist = new List<int>();
                    string ScaleDetial = "";
                    int count = 0;
                    for (int z = 0; z < dsPredicSetting.Tables[0].Rows.Count; z++)
                    {
                        if (factorysation == dsPredicSetting.Tables[0].Rows[z]["FactorySation"].ToString() && signal == dsPredicSetting.Tables[0].Rows[z]["Signal"].ToString())
                        {
                            ScaleDetial = dsPredicSetting.Tables[0].Rows[z]["ScaleDetial"].ToString();
                            count++;
                            break;
                        }
                    }
                    if (count>0)
                    {
                        string[] arr = ScaleDetial.Split(':');
                        for (int j = 0; i < arr.Length;j++)
                        {
                            shijilist.Add(int.Parse(arr[j]));
                        }
                    }
                    else
                    {
                        shijilist = shijilistbili;
                    }
                    int surplus = totalday - usedtimes;
                
                        int playthisday = surplus * shijilist[dt.Day - 1] / (shijilist.Sum()- shijilist.Take(dt.Day - 1).Sum());
                        int shijithisday = int.Parse(ds.Tables[0].Rows[i]["HappenTimes"].ToString());

                    if (playthisday < shijithisday)
                    {
                        M_HitchInfoView.PlanTimes = playthisday;
                        M_HitchInfoView.Signal = signal;
                        M_HitchInfoView.FactorySation = factorysation;
                        M_HitchInfoView.HappenTimes = shijithisday;
                        M_HitchInfoViewlist.Add(M_HitchInfoView);
                    }




                }

               }
             M_HitchInfoViewlist.Sort((x, y) =>
            {
                if (x.HappenTimes - x.PlanTimes > y.HappenTimes - y.PlanTimes)
                {
                    return -1;
                }
                else if(x.HappenTimes - x.PlanTimes > y.HappenTimes - y.PlanTimes)
                {
                    return 0;
                }
                else
                {
                    return 1;
                }
            }
            );
            return M_HitchInfoViewlist;

            }

           
        

    }
}
