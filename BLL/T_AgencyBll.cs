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
   public  class T_AgencyBll
    {
        public int Add(T_Agency model)
        {
            return T_AgencyDal.GetInstance().Add(model);
        }
        public int Update(T_Agency model)
        {
            return T_AgencyDal.GetInstance().Update(model);
        }
        public int Del(int id)
        {
            return T_AgencyDal.GetInstance().Del(id);
        }
        public List<T_Agency> GetList()
        {
            return T_AgencyDal.GetInstance().GetList();
        }
        public T_Agency GetModel(int id)
        {

            return T_AgencyDal.GetInstance().GetModel(id);
        }
        public int DelList(string idlist)
        {
            return T_AgencyDal.GetInstance().DelList(idlist);

        }
        public int UpdateAll(string idlist)
        {
            return T_AgencyDal.GetInstance().UpdateAll(idlist);
        }
        public List<SelectListItem> SelectListItem()
        {
            var list = GetList();
            List<SelectListItem> listselect = new List<SelectListItem>();
            listselect.Add(new SelectListItem() { Text = "全部", Value = "0" });
            foreach (var item in list)
            {
                listselect.Add(new SelectListItem() { Text = item.AgencyName, Value = item.AgencyId.ToString() });
            }
            return listselect;
        }


    }
}
