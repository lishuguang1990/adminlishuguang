using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Utilities.Base.File
{
   public static  class ExportFile
    {
        public static System.Data.DataSet ExcelSqlConnection(string filepath, string tableName)
        {
            string strCon = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filepath + ";Extended Properties='Excel 8.0;HDR=YES;IMEX=1'";
            OleDbConnection ExcelConn = new OleDbConnection(strCon);
            try
            {
                string strCom = string.Format("SELECT * FROM [监控信息日频发统计$]");
                ExcelConn.Open();
                OleDbDataAdapter myCommand = new OleDbDataAdapter(strCom, ExcelConn);
                DataSet ds = new DataSet();
                myCommand.Fill(ds, "[" + tableName + "$]");
                ExcelConn.Close();
                return ds;
            }
            catch
            {
                ExcelConn.Close();
                return null;
            }
        }
    }
}
