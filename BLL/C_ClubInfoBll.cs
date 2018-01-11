using DAL;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public   class  C_ClubInfoBll
    {
        public int Add(C_ClubInfo model)
        {
            return C_ClubInfoDal.GetInstance().Add(model);
        }
        public int Update(C_ClubInfo model)
        {
            return C_ClubInfoDal.GetInstance().Update(model);
        }
        public int Del(int id)
        {
            return C_ClubInfoDal.GetInstance().Del(id);
        }
        public List<C_ClubInfo> GetList()
        {
            return C_ClubInfoDal.GetInstance().GetList();
        }
        public C_ClubInfo GetModel(int id)
        {

            return C_ClubInfoDal.GetInstance().GetModel(id);
        }
        public int DelList(string idlist)
        {
            return C_ClubInfoDal.GetInstance().DelList(idlist);

        }
        public int UpdateAll(string idlist)
        {
            return C_ClubInfoDal.GetInstance().UpdateAll(idlist);
        }
 
    }
}
