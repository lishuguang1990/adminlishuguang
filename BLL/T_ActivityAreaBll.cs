using DAL;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace BLL
{
   public  class T_ActivityAreaBll
    {
     
        public int Add(T_ActivityArea model)
        {
            return T_ActivityAreaDal.GetInstance().Add(model);
        }
        public int Update(T_ActivityArea model)
        {
            return T_ActivityAreaDal.GetInstance().Update(model);
        }
        public int Del(int id)
        {
            return T_ActivityAreaDal.GetInstance().Del(id);
        }
        public List<T_ActivityArea> GetList()
        {
            return T_ActivityAreaDal.GetInstance().GetList();
        }
        public T_ActivityArea GetModel(int id)
        {

            return T_ActivityAreaDal.GetInstance().GetModel(id);
        }
       public int DelList(string idlist)
        {
            return T_ActivityAreaDal.GetInstance().DelList(idlist);

        }
        public int UpdateAll(string idlist)
        {
            return T_ActivityAreaDal.GetInstance().UpdateAll(idlist);
        }

        public  List<SelectListItem> SelectListItem()
        {
            var list = GetList();
            List<SelectListItem> listselect = new List<SelectListItem>();
            listselect.Add(new SelectListItem() { Text ="全部", Value ="0" });
            foreach (var item in list)
            {
                listselect.Add(new SelectListItem() { Text = item.ActivityName, Value = item.ActivitAreaId.ToString() });
            }
            return listselect;
       }


    }
}
