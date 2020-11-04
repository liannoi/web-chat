using System;
using AutoMapper;
using WebChat.Application.API.Common.Mappings;

namespace WebChat.Application.API.Storage.ConversationMessages.Models
{
    public class DetailsViewModel : IMapFrom<Domain.API.Entities.ConversationMessages>
    {
        public int ConversationMessageId { get; set; }
        public Conversations.Models.DetailsViewModel Conversation { get; set; }
        public int OwnerUserId { get; set; }
        public string Message { get; set; }
        public DateTime Publish { get; set; }

        public void Mapping(Profile profile)
        {
            profile.CreateMap<Domain.API.Entities.ConversationMessages, DetailsViewModel>()
                .ForMember(dest => dest.ConversationMessageId, opt => opt.MapFrom(s => s.ConversationMessageId))
                .ForMember(dest => dest.Conversation, opt => opt.MapFrom(s => s.Conversation))
                .ForMember(dest => dest.OwnerUserId, opt => opt.MapFrom(s => s.OwnerUserId))
                .ForMember(dest => dest.Message, opt => opt.MapFrom(s => s.Message))
                .ForMember(dest => dest.Publish, opt => opt.MapFrom(s => s.Publish));
        }
    }
}