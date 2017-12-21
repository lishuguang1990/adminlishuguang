using Dal;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
  public  class M_SolutionBll
    {
        public int M_SolutionAdd(M_Solution model)
        {
            return M_SolutionDal.GetInstance().M_SolutionAdd(model);
        }
    }
}
