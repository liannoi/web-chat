using System.Threading;
using System.Threading.Tasks;
using MediatR;
using WebChat.Application.API.Common.Identity;

namespace WebChat.Application.API.Storage.Users.Identity.Commands.Login
{
    public class LoginCommand : IRequest<string>
    {
        public string UserName { get; set; }
        public string Password { get; set; }

        private class Handler : IRequestHandler<LoginCommand, string>
        {
            private readonly IIdentityService _identityService;

            public Handler(IIdentityService identityService)
            {
                _identityService = identityService;
            }

            public async Task<string> Handle(LoginCommand request, CancellationToken cancellationToken)
            {
                var tmp = await _identityService.GetUserAsync(request.UserName, request.Password);

                return tmp.Token;
            }
        }
    }
}