using Om.App_Start;
using System.Web;
using System.Web.Mvc;

namespace Om
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
          //  filters.Add(new HandleErrorAttribute());
            filters.Add(new CustomerErrorHadlerAttribute());
        }
    }
}
