using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Linq;

namespace ConsoleApplication2
{
    class Program
    {
        static void Main(string[] args)
        {
            XmlDocument doc = new XmlDocument();
            //Path.Combine()

            //  var path = Environment.CurrentDirectory + "/APP/Send.xml";
            //string abc = AppDomain.CurrentDomain.BaseDirectory;
            //  doc.Load(@"D:\李曙光\Git\admin\ConsoleApplication2\APP\Send.xml");

            //   XmlNode xn = doc.SelectSingleNode("root");

            //var ck = xn.ChildNodes;
            //int status = 1;
            //foreach (var item in ck)
            //{
            //    XmlElement xe = (XmlElement)item;
            //    var stateid = xe.GetAttribute("id");
            //    if (stateid == status.ToString())
            //    {
            //        var rolenode = xe.SelectSingleNode("role").ChildNodes;
            //        foreach (var item1 in rolenode)
            //        {
            //            XmlElement xx = (XmlElement)item1;
            //            if (xx.GetAttribute("id") == "1")
            //            {

            //            }
            //        }
            //        break;
            //    }

            //}

            //linq
            XDocument xl = XDocument.Load(@"D:\李曙光\Git\admin\ConsoleApplication2\APP\Send.xml");
            var state = 10;
            var role = 1;
            var query = from a in xl.Element("root").Elements().Where(a => a.Attribute("name").Value == "待审核").Elements().Where(b => b.Attribute("name").Value == "中台").Elements()
                        select new
                        {
                            name = a.Attribute("name").Value,
                            id = a.Attribute("abc")==null?"123":"456"
                        };
            foreach (var item in query)
            {
                Console.WriteLine(item.name);
                Console.WriteLine(item.id);
            }
            Console.Read();


        }
    }
}
