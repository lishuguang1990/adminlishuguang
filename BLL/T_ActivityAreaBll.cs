using DAL;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
    }
}
