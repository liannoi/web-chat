using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using AutoMapper;
using AutoMapper.QueryableExtensions;
using MediatR;
using Microsoft.EntityFrameworkCore;
using WebChat.Application.API.Common.Interfaces;
using WebChat.Application.API.Storage.Conversations.Core.Core.Models;

namespace WebChat.Application.API.Storage.Conversations.Core.LeftOrRight.Queries
{
    public class ListQuery : IRequest<ListViewModel>
    {
        public int UserId { get; set; }

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
                var tmp = await _context.Conversations
                    .Where(c => c.LeftUserId == request.UserId || c.RightUserId == request.UserId)
                    .ProjectTo<DetailsViewModel>(_mapper.ConfigurationProvider)
                    .ToListAsync(cancellationToken);

                return new ListViewModel {Conversations = tmp};
            }
        }
    }
}