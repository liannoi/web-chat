using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using WebChat.Application.API.Common.Identity;
using WebChat.Application.API.Common.Interfaces;
using WebChat.Application.API.Storage.Conversations.Core.Models;

namespace WebChat.Application.API.Storage.Conversations.LeftOrRight.Queries
{
    public class ListQuery : IRequest<ListViewModel>
    {
        public int UserId { get; set; }

        private class Handler : IRequestHandler<ListQuery, ListViewModel>
        {
            private readonly IWebChatContext _context;
            private readonly IIdentityService _identityService;
            private readonly IMapper _mapper;

            public Handler(IWebChatContext context, IMapper mapper, IIdentityService identityService)
            {
                _context = context;
                _mapper = mapper;
                _identityService = identityService;
            }

            public async Task<ListViewModel> Handle(ListQuery request, CancellationToken cancellationToken)
            {
                var conversations = await _context.Conversations
                    .Where(c => c.LeftUserId == request.UserId || c.RightUserId == request.UserId)
                    .ToListAsync(cancellationToken);

                var result = new List<DetailsViewModel>();

                foreach (var conversation in conversations)
                    result.Add(new DetailsViewModel
                    {
                        ConversationId = conversation.ConversationId,
                        LeftUser = _mapper.Map<Users.Models.DetailsViewModel>(
                            await _identityService.GetUserAsync(conversation.LeftUserId)),
                        RightUser = _mapper.Map<Users.Models.DetailsViewModel>(
                            await _identityService.GetUserAsync(conversation.RightUserId))
                    });

                return new ListViewModel {Conversations = result};
            }
        }
    }
}