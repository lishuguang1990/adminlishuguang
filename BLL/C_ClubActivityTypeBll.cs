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
  public   class C_ClubActivityTypeBll
    {
        public int Add(C_ClubActivityType model)
        {
            return C_ClubActivityTypeDal.GetInstance().Add(model);
        }
        public int Update(C_ClubActivityType model)
        {
            return C_ClubActivityTypeDal.GetInstance().Update(model);
        }
        public int Del(int id)
        {
            return C_ClubActivityTypeDal.GetInstance().Del(id);
        }
        public List<C_ClubActivityType> GetList()
        {
            return C_ClubActivityTypeDal.GetInstance().GetList();
        }
        public C_ClubActivityType GetModel(int id)
        {

            return C_ClubActivityTypeDal.GetInstance().GetModel(id);
        }
        public int DelList(string idlist)
        {
            return C_ClubActivityTypeDal.GetInstance().DelList(idlist);

        }
        public int UpdateAll(string idlist)
        {
            return C_ClubActivityTypeDal.GetInstance().UpdateAll(idlist);
        }
        public List<SelectListItem> SelectListItem()
        {
            var list = GetList();
            List<SelectListItem> listselect = new List<SelectListItem>();
            listselect.Add(new SelectListItem() { Text = "请选择", Value = "" });
            foreach (var item in list)
            {
                listselect.Add(new SelectListItem() { Text = item.ClubActivityTypeName, Value = item.ClubActivityTypeId.ToString() });
            }
            return listselect;
        }

    }
}
