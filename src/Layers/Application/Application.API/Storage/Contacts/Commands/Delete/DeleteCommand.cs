using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using WebChat.Application.API.Common.Interfaces;
using WebChat.Application.API.Storage.Contacts.Models;

namespace WebChat.Application.API.Storage.Contacts.Commands.Delete
{
    public class DeleteCommand : IRequest
    {
        public int ContactId { get; set; }

        private class Handler : IRequestHandler<DeleteCommand>
        {
            private readonly IWebChatContext _context;
            private readonly IMapper _mapper;

            public Handler(IWebChatContext context, IMapper mapper)
            {
                _context = context;
                _mapper = mapper;
            }

            public async Task<Unit> Handle(DeleteCommand request, CancellationToken cancellationToken)
            {
                var fined = await _context.Contacts
                    .Where(contact => contact.ContactId == request.ContactId)
                    .FirstOrDefaultAsync(cancellationToken);

                _context.Contacts.Remove(fined);
                await _context.SaveChangesAsync(cancellationToken);

                return Unit.Value;
            }
        }
    }
}