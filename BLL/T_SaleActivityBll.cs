using DAL;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
  public  class T_SaleActivityBll
    {
        public int Add(T_SaleActivity model)
        {
            return T_SaleActivityDal.GetInstance().Add(model);
        }
        public int Update(T_SaleActivity model)
        {
            return T_SaleActivityDal.GetInstance().Update(model);
        }
        public int Del(int id)
        {
            return T_SaleActivityDal.GetInstance().Del(id);
        }
        public List<T_SaleActivity> GetList()
        {
            return T_SaleActivityDal.GetInstance().GetList();
        }
        public T_SaleActivity GetModel(int id)
        {

            return T_SaleActivityDal.GetInstance().GetModel(id);
        }
        public int DelList(string idlist)
        {
            return T_SaleActivityDal.GetInstance().DelList(idlist);

        }
        public int UpdateAll(string idlist)
        {
            return T_SaleActivityDal.GetInstance().UpdateAll(idlist);
        }
    }
}
