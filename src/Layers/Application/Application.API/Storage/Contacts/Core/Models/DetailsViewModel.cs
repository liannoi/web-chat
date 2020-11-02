using AutoMapper;
using WebChat.Application.API.Common.Mappings;

namespace WebChat.Application.API.Storage.Contacts.Core.Models
{
    public class DetailsViewModel : IMapFrom<Domain.API.Entities.Contacts>
    {
        public int ContactId { get; set; }
        public int OwnerUserId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Photo { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<Domain.API.Entities.Contacts, DetailsViewModel>()
                .ForMember(dest => dest.ContactId, opt => opt.MapFrom(s => s.ContactId))
                .ForMember(dest => dest.OwnerUserId, opt => opt.MapFrom(s => s.OwnerUserId))
                .ForMember(dest => dest.FirstName, opt => opt.MapFrom(s => s.FirstName))
                .ForMember(dest => dest.LastName, opt => opt.MapFrom(s => s.LastName))
                .ForMember(dest => dest.Email, opt => opt.MapFrom(s => s.Email))
                .ForMember(dest => dest.Photo, opt => opt.MapFrom(s => s.Photo));
        }
    }
}