using DAL;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
  public   class T_SaleActivityTypeBll
    {
        public int Add(T_SaleActivityType model)
        {
            return T_SaleActivityTypeDal.GetInstance().Add(model);
        }
        public int Update(T_SaleActivityType model)
        {
            return T_SaleActivityTypeDal.GetInstance().Update(model);
        }
        public int Del(int id)
        {
            return T_SaleActivityTypeDal.GetInstance().Del(id);
        }
        public T_SaleActivityType GetModel(int id)
        {
            return T_SaleActivityTypeDal.GetInstance().GetModel(id);
        }
        public List<T_SaleActivityType> GetList()
        {
            return T_SaleActivityTypeDal.GetInstance().GetList();
        }
    }
}
