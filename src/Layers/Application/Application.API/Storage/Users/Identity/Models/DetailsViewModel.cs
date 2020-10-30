using AutoMapper;
using WebChat.Application.API.Common.Mappings;
using WebChat.Domain.API.Entities.Identity;

namespace WebChat.Application.API.Storage.Users.Identity.Models
{
    public class DetailsViewModel : IMapFrom<ApplicationUser>
    {
        public string UserName { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<ApplicationUser, DetailsViewModel>()
                .ForMember(dest => dest.UserName, opt => opt.MapFrom(s => s.UserName));
        }
    }
}