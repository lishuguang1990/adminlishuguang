using System.Web;
using System.Web.Optimization;

namespace Om
{
    public class BundleConfig
    {
        // 有关绑定的详细信息，请访问 http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            //bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
            //            "~/Scripts/jquery-{version}.js"));
            //bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
            //            "~/Scripts/jquery.validate*"));
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include("~/lib/jquery/1.9.1/jquery.min.js", "~/lib/layer/2.4/layer.js", "~/static/h-ui/js/H-ui.js", "~/static/h-ui.admin/js/H-ui.admin.page.js"));


            // 使用要用于开发和学习的 Modernizr 的开发版本。然后，当你做好
            // 生产准备时，请使用 http://modernizr.com 上的生成工具来仅选择所需的测试。
            //bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
            //            "~/Scripts/modernizr-*"));

            //bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
            //          "~/Scripts/bootstrap.js",
            //          "~/Scripts/respond.js"));

            //bundles.Add(new StyleBundle("~/Content/css").Include(
            //          "~/Content/bootstrap.css",
            //          "~/Content/site.css"));

            bundles.Add(new StyleBundle("~/Content/css").Include("~/static/h-ui/css/H-ui.min.css", "~/static/h-ui.admin/css/H-ui.admin.css", "~/lib/Hui-iconfont/1.0.8/iconfont.css", "~/static/h-ui.admin/css/style.css"));
        }
    }
}
