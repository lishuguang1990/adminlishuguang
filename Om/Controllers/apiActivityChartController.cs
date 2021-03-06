﻿using BLL;
using MallWCF.DBHelper;
using Model.ModelView;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using Utilities;
using static Model.ModelView.AgencyStatisticsViewModel;

namespace Om.Controllers
{
    [RoutePrefix("api/apiactivitychart")]
    [Route("{action}")]
  
    public class apiActivityChartController : ApiController
    {
        [HttpPost]
        [ActionName("getactivitytypestatisticslist")]
        //通过时间段获取所有活动类型的场次数量
        public Dictionary<string, object> GetActivityTypeStatisticsList()
        {
            T_SaleActivityTypeBll typebll = new T_SaleActivityTypeBll();
            var typelist = typebll.GetList();
            var database = DataFactory.Database();

            string begintime = HttpContext.Current.Request.Form["begintime"].ToString();
            string endtime = HttpContext.Current.Request.Form["endtime"].ToString();
            string strwhere = "IsDelete=0";
            if (!string.IsNullOrEmpty(begintime))
            {
                strwhere += " and ActivityDate>='" + begintime + "'";
            }
            if (!string.IsNullOrEmpty(endtime))
            {
                strwhere += " and ActivityDate<='" + endtime + "'";
            }
            var ds = database.FindDataSetBySql("select SaleActivityTypeId,count(SaleActivityTypeId) as total from T_SaleActivity where " + strwhere + "  group by SaleActivityTypeId");
            TypeStatisticsViewModel viewmodel = new TypeStatisticsViewModel();
            List<ActivityType> listtypeview = new List<ActivityType>();
            int total = 0;
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (var item in typelist)
                {
                    var row = ds.Tables[0].Select("SaleActivityTypeId=" + item.SaleActivityTypeId + "");
                    if (row.Length > 0)
                    {
                        total += int.Parse(row[0]["total"].ToString());
                        listtypeview.Add(new ActivityType() { Quantity = int.Parse(row[0]["total"].ToString()), TypeName = item.SaleActivityTypeName });
                    }
                    else
                    {
                        listtypeview.Add(new ActivityType() { Quantity = 0, TypeName = item.SaleActivityTypeName });
                    }
                }

            }
            else
            {
                foreach (var item in typelist)
                {
                    listtypeview.Add(new ActivityType() { Quantity = 0, TypeName = item.SaleActivityTypeName });
                }

            }
            viewmodel.Total = total;
            viewmodel.List = listtypeview;
            return new Dictionary<string, object>
            {
                { "result",viewmodel},
                { "code",1}
            };

        }
        [HttpPost]
        [ActionName("getagencystatisticslist")]
        //全国经销商活动场次统计
        public Dictionary<string, object> GetAgencyStatisticsList()
        {
            T_SaleActivityTypeBll typebll = new T_SaleActivityTypeBll();
            T_AgencyBll t_agencybll = new T_AgencyBll();
            T_ActivityAreaBll areabll = new T_ActivityAreaBll();
            var arealist = areabll.GetList();
            var typelist = typebll.GetList();
            var agencylist = t_agencybll.GetList();
            string begintime = HttpContext.Current.Request.Form["begintime"].ToString();
            string endtime = HttpContext.Current.Request.Form["endtime"].ToString();
            string areaid= HttpContext.Current.Request.Form["areaid"].ToString();
            string strwhere = "IsDelete=0";
            if (!string.IsNullOrEmpty(begintime))
            {
                strwhere += " and ActivityDate>='" + begintime + "'";
            }
            if (!string.IsNullOrEmpty(endtime))
            {
                strwhere += " and ActivityDate<='" + endtime + "'";
            }
            if (!string.IsNullOrEmpty(areaid))
            {
                strwhere += " and saleactivitytypeid=" + areaid;
            }
            else
            {
                strwhere += " and saleactivitytypeid=" + arealist[0];
            }
            string date = DateTime.Now.Year.ToString() + "-01-01";
            int indexmonth = DateTime.Now.Month;
            var listmonth = new List<int>();
            for (int i = 1; i < indexmonth + 1; i++)
            {
                listmonth.Add(i);
            }
            var database = DataFactory.Database();

            var dsaverage = database.FindDataSetBySql("select DATEPART(month, ActivityDate) as nmonth,agencyid,saleactivitytypeid from T_SaleActivity   where datediff(year, ActivityDate, '"+date+"') = 0 group by AgencyId, DATEPART(month, ActivityDate),SaleActivityTypeId order by DATEPART(month, ActivityDate)");
            List<AgencyStatisticsViewModel> listview = new List<AgencyStatisticsViewModel>();
            foreach (var item in agencylist)
            {
                var model = new AgencyStatisticsViewModel();
                model.AgencyName = item.AgencyName;
                model.AgencyId = item.AgencyId;
                List<Months> listmonthview = new List<Months>();
                foreach (var item1 in listmonth)
                {
                    var monthview = new Months();
                    monthview.Month = item1.ToString();
                    List<int> listid = new List<int>();
                    var dsselect = dsaverage.Tables[0].Select("nmonth=" + item1.ToString() + " and agencyid=" + item.AgencyId + "");
                    foreach (var item2 in dsselect)
                    {
                        if (!listid.Contains(int.Parse(item2["saleactivitytypeid"].ToString())))
                        {
                            listid.Add(int.Parse(item2["saleactivitytypeid"].ToString()));
                        }
                    }
                    monthview.SaleActivityTypeIdList = listid;
                    listmonthview.Add(monthview);
                  
                }
                model.listmonth = listmonthview;


                listview.Add(model);

            }
            return new Dictionary<string, object>
            {
                {"code",1 },
                {"typelist",typelist.Select(a=>new { saleactivitytypeid=a.SaleActivityTypeId,saleactivitytypename=a.SaleActivityTypeName})},
                {"agencylist",agencylist.Select(a=>new { agencyid=a.AgencyId,agencyname=a.AgencyName})},
                {"list",listview},
                {"monthlist",listmonth},
                { "arealist",arealist}

            };
        }
        [ActionName("geteverymonthaveragecost")]
        //每月不同类型活动场次及成本统计
        [HttpPost]
        public Dictionary<string, object> GetEveryMonthAverageCost()
        {
            T_SaleActivityTypeBll typebll = new T_SaleActivityTypeBll();
            var typelist = typebll.GetList();
            string date = DateTime.Now.Year.ToString() + "-01-01";
            // string month = HttpContext.Current.Request.Form["month"].ToString();
            var database = DataFactory.Database();
            int indexmonth = DateTime.Now.Month;
            var listmonth = new List<int>();
            for (int i = 1; i < indexmonth + 1; i++)
            {
                listmonth.Add(i);
            }
            //计算出当前年份每月，每种类型的场次数量成本的平均值 
            var dsaverage = database.FindDataSetBySql("select DATEPART(month, ActivityDate) as month, (sum(PrimeCost) / count(SaleActivityTypeId)) as average, count(SaleActivityTypeId) as count, saleactivitytypeid from T_SaleActivity  where datediff(year,ActivityDate,'" + date + "')=0 group by SaleActivityTypeId, DATEPART(month, ActivityDate) order by DATEPART(month,ActivityDate)");
            var alldsaverage = database.FindDataSetBySql("select  DATEPART(month,ActivityDate) as nmonth,sum(PrimeCost)/count(PrimeCost) as average  from T_SaleActivity where datediff(year,ActivityDate,'" + date + "')=0 group by DATEPART(month,ActivityDate) order by DATEPART(month,ActivityDate)");
            return new Dictionary<string, object>
            {
               {"code",1 },
               { "typelist",typelist.Select(a=>new { saleactivitytypeid=a.SaleActivityTypeId,saleactivitytypename=a.SaleActivityTypeName})},
                {"allaveragelist",alldsaverage.Tables[0]},
               { "averagebytypelist",dsaverage.Tables[0]},
                { "monthlist",listmonth}
            };
        }

        [HttpPost]
        //每月不同类型活动场均客流统计
        [ActionName("geteverymonthaveragepassengerflow")]
        public Dictionary<string, object> GetEveryMonthAveragePassengerFlow()
        {
            T_SaleActivityTypeBll typebll = new T_SaleActivityTypeBll();
            var typelist = typebll.GetList();

            string date = DateTime.Now.Year.ToString() + "-01-01";
            // string month = HttpContext.Current.Request.Form["month"].ToString();
            var database = DataFactory.Database();
            //  //按照类型获取当年所有月份的平均客流量
            var dsaverage = database.FindDataSetBySql("select DATEPART(month, ActivityDate) as month, (sum(PassengerFlow) / count(SaleActivityTypeId)) as average, count(SaleActivityTypeId) as count, saleactivitytypeid,sum(PassengerFlow) as totalpassengerflow from T_SaleActivity  where datediff(year,ActivityDate,'" + date + "')=0 group by SaleActivityTypeId, DATEPART(month, ActivityDate) order by DATEPART(month,ActivityDate)");
            var alldsaverage = database.FindDataSetBySql("select  DATEPART(month,ActivityDate) as nmonth,sum(PassengerFlow) as totalpassengerflow from T_SaleActivity where datediff(year,ActivityDate,'" + date + "')=0 group by DATEPART(month,ActivityDate) order by DATEPART(month,ActivityDate)");
            int indexmonth = DateTime.Now.Month;
            var listmonth = new List<int>();
            for (int i = 1; i < indexmonth + 1; i++)
            {
                listmonth.Add(i);
            }
            return new Dictionary<string, object>
            {
                {"code",1 },
                { "typelist",typelist.Select(a=>new { saleactivitytypeid=a.SaleActivityTypeId,saleactivitytypename=a.SaleActivityTypeName})},
                {"alltotallist",alldsaverage.Tables[0]},
               { "averagebytypelist",dsaverage.Tables[0]},
                { "monthlist",listmonth}
            };
        }
        [HttpPost]
        [ActionName("geteverymonthaverageorder")]
        //每月不同类型活动平均订单数量统计
        public Dictionary<string, object> GetEveryMonthAverageOrder()
        {
            T_SaleActivityTypeBll typebll = new T_SaleActivityTypeBll();
            var typelist = typebll.GetList();

            string date = DateTime.Now.Year.ToString() + "-01-01";
            // string month = HttpContext.Current.Request.Form["month"].ToString();
            var database = DataFactory.Database();
            int indexmonth = DateTime.Now.Month;
            var listmonth = new List<int>();
            for (int i = 1; i < indexmonth + 1; i++)
            {
                listmonth.Add(i);
            }
            //按照类型获取当年所有月份的平均现场订单数量,和后续订单平均量
            var dsaverage = database.FindDataSetBySql("select saleactivitytypeid, DATEPART(month, ActivityDate) as nmonth, sum(OrderQuantity) / count(SaleActivityTypeId) as orderquantityaverage, sum(LaterOrderQuantity) / count(SaleActivityTypeId) as laterorderquantityaverage from T_SaleActivity   where datediff(year, ActivityDate, '"+date+"') = 0 group by SaleActivityTypeId, DATEPART(month, ActivityDate) order by DATEPART(month, ActivityDate)");
            return new Dictionary<string, object>
            {
                {"code",1 },
                { "typelist",typelist.Select(a=>new { saleactivitytypeid=a.SaleActivityTypeId,saleactivitytypename=a.SaleActivityTypeName})},
                {"averagelist",dsaverage.Tables[0]},
                { "monthlist",listmonth}
            };
        }
        [HttpPost]
        [ActionName("geteverymonthaveragelatentpassengerflow")]
        //每月不同类型活动平均潜客统计
        public Dictionary<string, object> GetEveryMonthAverageLatentPassengerFlow()
        {
            T_SaleActivityTypeBll typebll = new T_SaleActivityTypeBll();
            var typelist = typebll.GetList();
            string date = DateTime.Now.Year.ToString() + "-01-01";
            // string month = HttpContext.Current.Request.Form["month"].ToString();
            var database = DataFactory.Database();
            int indexmonth = DateTime.Now.Month;
            var listmonth = new List<int>();
            for (int i = 1; i < indexmonth + 1; i++)
            {
                listmonth.Add(i);
            }
            //按照类型获取当年所有月份的平均现场订单数量,和后续订单平均量
            var dsaverage = database.FindDataSetBySql("select saleactivitytypeid, DATEPART(month, ActivityDate) as nmonth,  sum(LatentPassengerFlow) / count(SaleActivityTypeId) as latentpassengerflowaverage from T_SaleActivity   where datediff(year, ActivityDate, '2018-01-01') = 0 group by SaleActivityTypeId, DATEPART(month, ActivityDate) order by DATEPART(month, ActivityDate)");
            return new Dictionary<string, object>
            {
                {"code",1 },
                { "typelist",typelist.Select(a=>new { saleactivitytypeid=a.SaleActivityTypeId,saleactivitytypename=a.SaleActivityTypeName})},
                {"averagelist",dsaverage.Tables[0]},
                 { "monthlist",listmonth}
            };
        }
        [HttpPost]
        [ActionName("geteverymonthpublishwaystatistics")]
        // 经销商活动后续宣传发布统计
        public Dictionary<string, object> GetEveryMonthPublishWayStatistics()
        {
            T_AgencyBll t_agencybll = new T_AgencyBll();
            var agencylist = t_agencybll.GetList();
            string date = DateTime.Now.Year.ToString() + "-01-01";
            var database = DataFactory.Database();
            int indexmonth = DateTime.Now.Month;
            var listmonth = new List<int>();
            for (int i = 1; i < indexmonth + 1; i++)
            {
                listmonth.Add(i);
            }
            var pubishwaylist = new Utilities.PublishWay().ToSelectListItem();
            var listdic = new Dictionary<int, object>();
            var dsaverage = database.FindDataSetBySql("select  DATEPART(month,ActivityDate) as nmonth,PublishWay,AgencyId from T_SaleActivity   where datediff(year,ActivityDate,'" + date + "')=0 group by DATEPART(month,ActivityDate),PublishWay,AgencyId order by DATEPART(month,ActivityDate)");
            foreach (var item in agencylist)
            {
                List<PublishwayStatistics> listway = new List<PublishwayStatistics>();
                foreach (var item1 in listmonth)
                {
                    PublishwayStatistics model = new PublishwayStatistics();
                    var list = new List<int>();
                    model.Month = item1;

                    var result = dsaverage.Tables[0].Select($"AgencyId={item.AgencyId} and nmonth={item1}");
                    foreach (var item2 in result)
                    {
                        var PublishWay = item2["PublishWay"].ToString();
                        var arraypublishway = PublishWay.Split(',');
                        if (list.Count == pubishwaylist.Count())
                        {
                            break;
                        }
                        else
                        {
                            foreach (var item4 in arraypublishway)
                            {
                                if (!list.Contains(int.Parse(item4)))
                                {
                                    list.Add(int.Parse(item4));
                                }
                            }
                        }


                    }

                    model.Publishwaylist = list;
                    listway.Add(model);
                    //if(result.Where(a=>a["PublishWay"])
                }

                listdic.Add(item.AgencyId, listway);


            }

            return new Dictionary<string, object>
            {
                {"code",1 },
                {"agencylist",agencylist.Select(a=>new {agencyid=a.AgencyId,agencyname=a.AgencyName})},
                {"averagelist",listdic},
                {"monthlist",listmonth},
                {"pubishwaylist",pubishwaylist.Select(a=>new {pubishwayid=a.Value,pubishwayname=a.Text})}
            };
        }
        [HttpPost]
        //每月不同类型活动单潜客成本及潜客成本转化率活动 成本金额总和/活动订单量
        [ActionName("geteverymonthpassengerflowchange")]
        public Dictionary<string, object> GetEveryMonthPassengerFlowChange()
        {
            T_SaleActivityTypeBll typebll = new T_SaleActivityTypeBll();
            var typelist = typebll.GetList();
            string date = DateTime.Now.Year.ToString() + "-01-01";
            // string month = HttpContext.Current.Request.Form["month"].ToString();
            var database = DataFactory.Database();
            int indexmonth = DateTime.Now.Month;
            var listmonth = new List<int>();
            for (int i = 1; i < indexmonth + 1; i++)
            {
                listmonth.Add(i);
            }
            //潜客成本 活动总金额/潜客总量
            //潜客转化率 潜客量/总量
            var dsaverage = database.FindDataSetBySql("select saleactivitytypeid, DATEPART(month, ActivityDate) as nmonth,  sum(PrimeCost) / sum(LatentPassengerFlow) as LatentPassengerFlowcost, CONVERT(varchar(20),(Round(CONVERT(float,(sum(LatentPassengerFlow))) / sum(PassengerFlow),2)*100))+'%' as rate  from T_SaleActivity   where datediff(year, ActivityDate, '" + date+"') = 0 group by SaleActivityTypeId, DATEPART(month, ActivityDate) order by DATEPART(month, ActivityDate)");
            //每个月的总平均值
            var alldsaverage = database.FindDataSetBySql("select  DATEPART(month, ActivityDate) as nmonth,  sum(PrimeCost) / sum(LatentPassengerFlow) as LatentPassengerFlowcost, CONVERT(varchar(20),(Round(CONVERT(float,(sum(LatentPassengerFlow))) / sum(PassengerFlow),2)*100))+'%' as rate from T_SaleActivity   where datediff(year, ActivityDate, '2018-01-01') = 0 group by  DATEPART(month, ActivityDate) order by DATEPART(month, ActivityDate)");
            return new Dictionary<string, object>
            {
                 {"code",1 },
                 {"typelist",typelist.Select(a=>new { saleactivitytypeid=a.SaleActivityTypeId,saleactivitytypename=a.SaleActivityTypeName})},
                 {"averagelist",dsaverage.Tables[0]},
                 {"allaveragelist",alldsaverage.Tables[0]},
                 {"monthlist",listmonth}
            };
        }
        [HttpPost]
        //没有不同类型车主俱乐部活动场均成本
        [ActionName("geteverymonthclubaveragecost")]
        public Dictionary<string, object> GetEveryMonthClubAverageCost()
        {
            C_ClubActivityTypeBll typebll = new C_ClubActivityTypeBll();
            var typelist = typebll.GetList();
            string date = DateTime.Now.Year.ToString() + "-01-01";
            var database = DataFactory.Database();
            int indexmonth = DateTime.Now.Month;
            var listmonth = new List<int>();
            for (int i = 1; i < indexmonth + 1; i++)
            {
                listmonth.Add(i);
            }
            //车主俱乐部活动按照类型统计每月平均成本价格
            var dsaverage = database.FindDataSetBySql("select clubactivitytypeid, DATEPART(month, ActivityDate) as nmonth, sum(ActivityCost) / count(ClubActivityInfoId)  as costaverage from C_ClubActivityInfo   where datediff(year, ActivityDate, '" + date + "') = 0 group by ClubActivityTypeId, DATEPART(month, ActivityDate) order by DATEPART(month, ActivityDate)");
            var dsaveragelist = database.FindDataSetBySql("select DATEPART(month, ActivityDate) as nmonth, sum(ActivityCost) / count(ClubActivityInfoId)  as costaverage from C_ClubActivityInfo   where datediff(year, ActivityDate, '" + date + "') = 0 group by DATEPART(month, ActivityDate) order by DATEPART(month, ActivityDate)");
            return new Dictionary<string, object>
            {
            {"code",1 },
            {"typelist",typelist.Select(a=>new {saleactivitytypeid=a.ClubActivityTypeId,saleactivitytypename=a.ClubActivityTypeName})},
            {"averagelist",dsaverage.Tables[0]},
            {"allaveragelist",dsaveragelist},
            {"monthlist",listmonth}
            };
        }
        [HttpPost]
        //每月不同类型车主俱乐部活动场次统计
        [ActionName("geteverymonthclubactivitybuildecount")]
        public Dictionary<string, object> GetEveryMonthClubActivityBuildeCount()
        {
            C_ClubActivityTypeBll typebll = new C_ClubActivityTypeBll();
            var typelist = typebll.GetList();
            string date = DateTime.Now.Year.ToString() + "-01-01";
            var database = DataFactory.Database();
            int indexmonth = DateTime.Now.Month;
            var listmonth = new List<int>();
            for (int i = 1; i < indexmonth + 1; i++)
            {
                listmonth.Add(i);
            }
           
            var dsaverage = database.FindDataSetBySql("select DATEPART(month, ActivityDate) as nmonth, count(ClubActivityInfoId) as count,clubactivitytypeid from C_ClubActivityInfo   where datediff(year, ActivityDate, '" + date+ "') = 0 group by DATEPART(month, ActivityDate),ClubActivityTypeId order by DATEPART(month, ActivityDate)");
            return new Dictionary<string, object>
            {
                {"code",1 },
                {"typelist",typelist.Select(a=>new {saleactivitytypeid=a.ClubActivityTypeId,saleactivitytypename=a.ClubActivityTypeName})},
                {"averagelist",dsaverage.Tables[0]},
                {"monthlist",listmonth}
            };
        }
        [HttpPost]
        //每月不同类型活动单订单成本及订单转化率
        [ActionName("getevertymonthordercostlist")]
        public Dictionary<string, object> GetEvertyMonthOrderCostList()
        {
            T_SaleActivityTypeBll typebll = new T_SaleActivityTypeBll();
            var typelist = typebll.GetList();
            string date = DateTime.Now.Year.ToString() + "-01-01";
            // string month = HttpContext.Current.Request.Form["month"].ToString();
            var database = DataFactory.Database();
            int indexmonth = DateTime.Now.Month;
            var listmonth = new List<int>();
            for (int i = 1; i < indexmonth + 1; i++)
            {
                listmonth.Add(i);
            }
            //订单成本   活动总金额/活动现场订单量+后续订单量
            //订单转化率 活动现场订单量+后续订单量/潜客量
            var dsaverage = database.FindDataSetBySql("  select saleactivitytypeid, DATEPART(month, ActivityDate) as nmonth,  sum(PrimeCost) / sum(OrderQuantity+LaterOrderQuantity) as ordercost, CONVERT(varchar(20),(Round(CONVERT(float,(sum(OrderQuantity+LaterOrderQuantity))) / sum(LatentPassengerFlow),2)*100))+'%' as rate  from T_SaleActivity   where datediff(year, ActivityDate, '"+date+"') = 0 group by SaleActivityTypeId, DATEPART(month, ActivityDate) order by DATEPART(month, ActivityDate)");
            //每个月的总平均值
            var alldsaverage = database.FindDataSetBySql("    select  DATEPART(month, ActivityDate) as nmonth,  sum(PrimeCost) / sum(OrderQuantity+LaterOrderQuantity) as ordercost, CONVERT(varchar(20),(Round(CONVERT(float,(sum(OrderQuantity+LaterOrderQuantity))) / sum(LatentPassengerFlow),2)*100))+'%' as rate  from T_SaleActivity   where datediff(year, ActivityDate, '"+date+"') = 0 group by DATEPART(month, ActivityDate) order by DATEPART(month, ActivityDate)");
            return new Dictionary<string, object>
            {
                 {"code",1 },
                 {"typelist",typelist.Select(a=>new { saleactivitytypeid=a.SaleActivityTypeId,saleactivitytypename=a.SaleActivityTypeName})},
                 {"averagelist",dsaverage.Tables[0]},
                 {"allaveragelist",alldsaverage.Tables[0]},
                 {"monthlist",listmonth}
            };
        }
        //全国经销商车主俱乐部概况统计
     [HttpPost]
        [ActionName("getbuildclubinfo")]
        public Dictionary<string, object> GetBuildClubInfo()
        {
            T_SaleActivityTypeBll typebll = new T_SaleActivityTypeBll();
            var typelist = typebll.GetList();
            var database = DataFactory.Database();
            string begintime = HttpContext.Current.Request.Form["begintime"].ToString();
            string endtime = HttpContext.Current.Request.Form["endtime"].ToString();
            string strwhere = "IsDelete=0";
            if (!string.IsNullOrEmpty(begintime))
            {
                strwhere += " and ClubDate>='" + begintime + "'";
            }
            if (!string.IsNullOrEmpty(endtime))
            {
                strwhere += " and ClubDate<='" + endtime + "'";
            }
            var ds = database.FindDataSetBySql("select sum(BuildedClubNumber) as buildedclubnumber,sum([PlaneBuilderClubNumber]) as planebuilderclubnumber,sum([NotBuilderClubNumber]) as  notbuilderclubnumber from C_ClubInfo where "+ strwhere);
           
            return new Dictionary<string, object>
            {
                { "result",ds.Tables[0]},
                { "code",1}
            };
        }
        [HttpPost]
        public Dictionary<string, object> Login()
        {
              UserBll bll = new UserBll();
            string UserName = HttpContext.Current.Request.Form["UserName"].ToString();
            string PassWord = HttpContext.Current.Request.Form["PassWord"].ToString();
            return bll.Login(UserName, PassWord);
        }


    }
}
