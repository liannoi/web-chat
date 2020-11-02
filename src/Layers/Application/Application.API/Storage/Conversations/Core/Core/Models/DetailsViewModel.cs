using AutoMapper;
using WebChat.Application.API.Common.Mappings;

namespace WebChat.Application.API.Storage.Conversations.Core.Core.Models
{
    public class DetailsViewModel : IMapFrom<Domain.API.Entities.Conversations>
    {
        public int ConversationId { get; set; }

        public int LeftUserId { get; set; }
        public int RightUserId { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<Domain.API.Entities.Conversations, DetailsViewModel>()
                .ForMember(dest => dest.ConversationId, opt => opt.MapFrom(s => s.ConversationId))
                .ForMember(dest => dest.LeftUserId, opt => opt.MapFrom(s => s.LeftUserId))
                .ForMember(dest => dest.RightUserId, opt => opt.MapFrom(s => s.RightUserId));
        }
    }
}