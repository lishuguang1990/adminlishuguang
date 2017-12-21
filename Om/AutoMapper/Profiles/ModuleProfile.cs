using AutoMapper;
using Model;
using Model.ModelView;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Om.AutoMapper.Profiles
{
    public class ModuleProfile:Profile
    {
        protected override void Configure()
        {
            CreateMap<Module, ModuleViewModel>().ForMember(entity => entity.name, opt => opt.MapFrom(src => src.ModuleName)).ForMember(entity=>entity.isParent,opt=>opt.MapFrom(src=>src.ParentId==0?true:false));
        }
    }
}