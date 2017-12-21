using MallWCF.DBHelper;
using Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class PredicSettingDal : RepositoryFactory<PredicSetting>
    {
        private static PredicSettingDal _instance;
        private static object _object = new Object();
        public static PredicSettingDal GetInstance()
        {
            if (_instance == null)
            {
                lock (_object)
                {
                    if (_instance == null)
                    {
                        _instance = new PredicSettingDal();
                    }
                }
            }
            return _instance;
        }
        private PredicSettingDal()
        {

        }
        public int PredicSettingAdd(PredicSetting model)
        {
            return Repository().Insert(model);
        }
        public int PredicSettingEdit(PredicSetting model)
        {
            return Repository().Update(model);
        }
        public PredicSetting GetModel(int id)
        {
            return Repository().FindEntity(id);
        }

        public int PredicSettingDel(int id)
        {
            return Repository().Delete(id);
        }
    }
}
