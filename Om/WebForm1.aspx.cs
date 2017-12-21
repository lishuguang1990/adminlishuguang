using BLL;
using LeaRun.Utilities;
using Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Utilities.Base.File;

namespace Om
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string path = HttpContext.Current.Server.MapPath("/App_Data/selfsetting.xml");
            XmlDocument xmldoc = new XmlDocument();
            xmldoc.Load(path);
            string time = xmldoc.SelectSingleNode("root").SelectSingleNode("daorutime").Attributes[0].Value;
            string daorupath = xmldoc.SelectSingleNode("root").SelectSingleNode("daorudir").Attributes[0].Value;
            var files = DirFileHelper.GetFileNames(daorupath);
            if (files.Length > 0)
            {
              
                DataSet ds = ExportFile.ExcelSqlConnection(files[0], "Info");           //调用自定义方法
                DataRow[] dr = ds.Tables[0].Select();
                int successcount = 0;
                int failcount = 0;
                M_HitchInfoBll M_HitchInfoBll = new M_HitchInfoBll();
                for (int i = 0; i < dr.Length; i++)
                {
                    try
                    {
                        M_HitchInfo model = new M_HitchInfo();
                        model.AreaName = dr[0][0].ToString();
                        model.FactorySation = dr[i][1].ToString();
                        model.Signal = dr[i][2].ToString();
                        model.HappenTimes = int.Parse(dr[i][3].ToString());
                        model.SignalType = dr[i][4].ToString();
                        model.HappenTimes1 = int.Parse(dr[i][5].ToString());
                        model.MessageType = dr[i][6].ToString();
                        model.CreateUserId = 1;
                        model.CreateUserName = "admin";
                        model.CreateTime = DateTime.Now.AddDays(-1);
                        if (M_HitchInfoBll.M_HitchInfoAdd(model) > 0)
                        {
                            successcount++;
                        }
                        else
                        {
                            failcount++;
                        }

                    }
                    catch (Exception)
                    {

                        failcount++;
                    }

                }

                File.Delete(files[0]);
            }
        }
    }
}