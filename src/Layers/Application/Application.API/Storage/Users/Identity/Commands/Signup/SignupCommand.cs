using System.Threading;
using System.Threading.Tasks;
using MediatR;
using WebChat.Application.API.Common.Identity;

namespace WebChat.Application.API.Storage.Users.Identity.Commands.Signup
{
    public class SignupCommand : IRequest<string>
    {
        public string UserName { get; set; }
        public string Password { get; set; }

        private class Handler : IRequestHandler<SignupCommand, string>
        {
            private readonly IIdentityService _identityService;

            public Handler(IIdentityService identityService)
            {
                _identityService = identityService;
            }

            public async Task<string> Handle(SignupCommand request, CancellationToken cancellationToken)
            {
                return (await _identityService.CreateUserAsync(request.UserName, request.Password)).Token;
            }
        }
    }
}