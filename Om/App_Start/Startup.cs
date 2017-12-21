using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Om.Startup))]
namespace Om
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
