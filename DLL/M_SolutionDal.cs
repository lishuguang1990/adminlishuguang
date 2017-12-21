using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dal
{
  public  class M_SolutionDal: RepositoryFactory<M_Solution>
    {
        private static M_SolutionDal _instance;
        private static object _object = new Object();
        public static M_SolutionDal GetInstance()
        {
            if (_instance == null)
            {
                lock (_object)
                {
                    if (_instance == null)
                    {
                        _instance = new M_SolutionDal();
                    }
                }
            }
            return _instance;
        }
        public int M_SolutionAdd(M_Solution model)
        {
          return   Repository().Insert(model);
        }
    }
}
