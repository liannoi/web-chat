using AutoMapper;
using WebChat.Application.API.Common.Mappings;
using WebChat.Domain.API.Identity;

namespace WebChat.Application.API.Storage.Users.Models
{
    public class DetailsViewModel : IMapFrom<ApplicationUser>
    {
        public int UserId { get; set; }
        public string UserName { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<ApplicationUser, DetailsViewModel>()
                .ForMember(dest => dest.UserId, opt => opt.MapFrom(s => s.Id))
                .ForMember(dest => dest.UserName, opt => opt.MapFrom(s => s.UserName));
        }
    }
}