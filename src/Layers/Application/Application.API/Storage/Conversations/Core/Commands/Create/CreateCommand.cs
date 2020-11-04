using System.Threading;
using System.Threading.Tasks;
using MediatR;
using WebChat.Application.API.Common.Interfaces;
using WebChat.Application.API.Storage.Users.Models;

namespace WebChat.Application.API.Storage.Conversations.Core.Commands.Create
{
    public class CreateCommand : IRequest
    {
        public int ConversationId { get; set; }
        public DetailsViewModel LeftUser { get; set; }
        public DetailsViewModel RightUser { get; set; }

        private class Handler : IRequestHandler<CreateCommand>
        {
            private readonly IWebChatContext _context;

            public Handler(IWebChatContext context)
            {
                _context = context;
            }

            public async Task<Unit> Handle(CreateCommand request, CancellationToken cancellationToken)
            {
                await _context.Conversations.AddAsync(new Domain.API.Entities.Conversations
                {
                    LeftUserId = request.LeftUser.UserId,
                    RightUserId = request.RightUser.UserId
                }, cancellationToken);

                await _context.SaveChangesAsync(cancellationToken);

                return Unit.Value;
            }
        }
    }
}