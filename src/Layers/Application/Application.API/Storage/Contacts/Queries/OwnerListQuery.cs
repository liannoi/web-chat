using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using AutoMapper;
using AutoMapper.QueryableExtensions;
using MediatR;
using Microsoft.EntityFrameworkCore;
using WebChat.Application.API.Common.Interfaces;
using WebChat.Application.API.Storage.Contacts.Models;

namespace WebChat.Application.API.Storage.Contacts.Queries
{
    public class OwnerListQuery : IRequest<ListViewModel>
    {
        public int OwnerUserId { get; set; }

        private class Handler : IRequestHandler<OwnerListQuery, ListViewModel>
        {
            private readonly IWebChatContext _context;
            private readonly IMapper _mapper;

            public Handler(IWebChatContext context, IMapper mapper)
            {
                _context = context;
                _mapper = mapper;
            }

            public async Task<ListViewModel> Handle(OwnerListQuery request, CancellationToken cancellationToken)
            {
                return new ListViewModel
                {
                    Contacts = await _context.Contacts
                        .Where(contact => contact.OwnerUserId == request.OwnerUserId)
                        .ProjectTo<DetailsViewModel>(_mapper.ConfigurationProvider).ToListAsync(cancellationToken)
                };
            }
        }
    }
}