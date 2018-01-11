using DAL;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
  public   class C_ClubActivityInfoBll
    {
        public int Add(C_ClubActivityInfo model)
        {
            return C_ClubActivityInfoDal.GetInstance().Add(model);
        }
        public int Update(C_ClubActivityInfo model)
        {
            return C_ClubActivityInfoDal.GetInstance().Update(model);
        }
        public int Del(int id)
        {
            return C_ClubActivityInfoDal.GetInstance().Del(id);
        }
        public List<C_ClubActivityInfo> GetList()
        {
            return C_ClubActivityInfoDal.GetInstance().GetList();
        }
        public C_ClubActivityInfo GetModel(int id)
        {

            return C_ClubActivityInfoDal.GetInstance().GetModel(id);
        }
        public int DelList(string idlist)
        {
            return C_ClubActivityInfoDal.GetInstance().DelList(idlist);

        }
        public int UpdateAll(string idlist)
        {
            return C_ClubActivityInfoDal.GetInstance().UpdateAll(idlist);
        }
    }
}
