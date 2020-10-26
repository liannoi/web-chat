using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using AutoMapper;
using AutoMapper.QueryableExtensions;
using MediatR;
using Microsoft.EntityFrameworkCore;
using WebChat.Application.API.Common.Interfaces;
using WebChat.Application.API.Storage.Contacts.Queries.List;

namespace WebChat.Application.API.Storage.Contacts.Models
{
    public class ListViewModel
    {
        public IList<DetailsViewModel> Contacts { get; set; }

        private class Handler : IRequestHandler<ListQuery, ListViewModel>
        {
            private readonly IWebChatContext _context;
            private readonly IMapper _mapper;

            public Handler(IWebChatContext context, IMapper mapper)
            {
                _context = context;
                _mapper = mapper;
            }

            public async Task<ListViewModel> Handle(ListQuery request, CancellationToken cancellationToken)
            {
                return new ListViewModel
                {
                    Contacts = await _context.Contacts
                        .ProjectTo<DetailsViewModel>(_mapper.ConfigurationProvider)
                        .ToListAsync(CancellationToken.None)
                };
            }
        }
    }
}