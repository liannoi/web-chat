using System;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using WebChat.Application.API.Common.Interfaces;
using WebChat.Application.API.Storage.Conversations.Models;

namespace WebChat.Application.API.Storage.ConversationMessages.Commands.Create
{
    public class CreateCommand : IRequest
    {
        public int ConversationMessageId { get; set; }
        public DetailsViewModel Conversation { get; set; }
        public int OwnerUserId { get; set; }
        public string Message { get; set; }
        public DateTime Publish { get; set; }

        private class Handler : IRequestHandler<CreateCommand>
        {
            private readonly IWebChatContext _context;
            private readonly IMediator _mediator;

            public Handler(IWebChatContext context, IMediator mediator)
            {
                _context = context;
                _mediator = mediator;
            }

            public async Task<Unit> Handle(CreateCommand request, CancellationToken cancellationToken)
            {
                var conversation = new Domain.API.Entities.ConversationMessages
                {
                    ConversationId = request.Conversation.ConversationId,
                    Message = request.Message,
                    Publish = request.Publish,
                    OwnerUserId = request.OwnerUserId
                };

                await _context.ConversationMessages.AddAsync(conversation, cancellationToken);
                await _context.SaveChangesAsync(cancellationToken);

                await _mediator.Publish(new MessageCreated {MessageId = conversation.ConversationMessageId},
                    cancellationToken);

                return Unit.Value;
            }
        }
    }
}