using AutoMapper;
using Om.AutoMapper.Profiles;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Om.App_Start
{
    public class AutoMapperConfig
    {
        public static void Configure()
        {
            Mapper.Initialize(cfg =>
            {
                cfg.AddProfile<ModuleProfile>();
            }
            );
        }
    }
}