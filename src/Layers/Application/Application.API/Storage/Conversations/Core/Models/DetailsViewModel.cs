using AutoMapper;
using WebChat.Application.API.Common.Mappings;

namespace WebChat.Application.API.Storage.Conversations.Core.Models
{
    public class DetailsViewModel : IMapFrom<Domain.API.Entities.Conversations>
    {
        public int ConversationId { get; set; }

        public Users.Models.DetailsViewModel LeftUser { get; set; }
        public Users.Models.DetailsViewModel RightUser { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<Domain.API.Entities.Conversations, DetailsViewModel>()
                .ForMember(dest => dest.ConversationId, opt => opt.MapFrom(s => s.ConversationId));
        }
    }
}