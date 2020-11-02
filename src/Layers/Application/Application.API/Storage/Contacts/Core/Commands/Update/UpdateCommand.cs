using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using AutoMapper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using WebChat.Application.API.Common.Interfaces;
using WebChat.Application.API.Storage.Contacts.Core.Models;

namespace WebChat.Application.API.Storage.Contacts.Core.Commands.Update
{
    public class UpdateCommand : IRequest<DetailsViewModel>
    {
        public int ContactId { get; set; }
        public int OwnerUserId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Photo { get; set; }

        private class Handler : IRequestHandler<UpdateCommand, DetailsViewModel>
        {
            private readonly IWebChatContext _context;
            private readonly IMapper _mapper;

            public Handler(IWebChatContext context, IMapper mapper)
            {
                _context = context;
                _mapper = mapper;
            }

            public async Task<DetailsViewModel> Handle(UpdateCommand request, CancellationToken cancellationToken)
            {
                var fined = await _context.Contacts
                    .Where(contact => contact.ContactId == request.ContactId)
                    .FirstOrDefaultAsync(cancellationToken);

                fined.OwnerUserId = request.OwnerUserId;
                fined.FirstName = request.FirstName;
                fined.LastName = request.LastName;
                fined.Email = request.Email;
                fined.Photo = request.Photo;
                await _context.SaveChangesAsync(cancellationToken);

                return _mapper.Map<DetailsViewModel>(fined);
            }
        }
    }
}