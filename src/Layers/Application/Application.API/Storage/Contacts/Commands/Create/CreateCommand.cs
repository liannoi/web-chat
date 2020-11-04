using System.Threading;
using System.Threading.Tasks;
using MediatR;
using WebChat.Application.API.Common.Interfaces;

namespace WebChat.Application.API.Storage.Contacts.Commands.Create
{
    public class CreateCommand : IRequest<int>
    {
        public int OwnerUserId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Photo { get; set; }

        private class Handler : IRequestHandler<CreateCommand, int>
        {
            private readonly IWebChatContext _context;

            public Handler(IWebChatContext context)
            {
                _context = context;
            }

            public async Task<int> Handle(CreateCommand request, CancellationToken cancellationToken)
            {
                var result = await _context.Contacts.AddAsync(new Domain.API.Entities.Contacts
                {
                    OwnerUserId = request.OwnerUserId,
                    Email = request.Email,
                    Photo = request.Photo,
                    FirstName = request.FirstName,
                    LastName = request.LastName
                }, cancellationToken);

                await _context.SaveChangesAsync(cancellationToken);

                return result.Entity.ContactId;
            }
        }
    }
}