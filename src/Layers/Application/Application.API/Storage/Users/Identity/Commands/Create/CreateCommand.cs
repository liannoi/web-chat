using System.Threading;
using System.Threading.Tasks;
using MediatR;
using WebChat.Application.API.Common.Interfaces;

namespace WebChat.Application.API.Storage.Users.Identity.Commands.Create
{
    public class CreateCommand : IRequest
    {
        public string UserName { get; set; }
        public string Password { get; set; }

        private class Handler : IRequestHandler<CreateCommand>
        {
            private readonly IIdentityService _identityService;

            public Handler(IIdentityService identityService)
            {
                _identityService = identityService;
            }

            public async Task<Unit> Handle(CreateCommand request, CancellationToken cancellationToken)
            {
                var tmp = await _identityService.CreateUserAsync(request.UserName, request.Password);

                return Unit.Value;
            }
        }
    }
}