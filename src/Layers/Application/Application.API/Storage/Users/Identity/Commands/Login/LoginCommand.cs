using System;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using WebChat.Application.API.Common.Identity;
using WebChat.Application.API.Storage.Users.Identity.Models;

namespace WebChat.Application.API.Storage.Users.Identity.Commands.Login
{
    public class LoginCommand : IRequest<JwtToken>
    {
        public string UserName { get; set; }
        public string Password { get; set; }

        private class Handler : IRequestHandler<LoginCommand, JwtToken>
        {
            private readonly IIdentityService _identityService;

            public Handler(IIdentityService identityService)
            {
                _identityService = identityService;
            }

            public async Task<JwtToken> Handle(LoginCommand request, CancellationToken cancellationToken)
            {
                try
                {
                    return (await _identityService.GetUserAsync(request.UserName, request.Password)).Token;
                }
                catch (UnauthorizedAccessException e)
                {
                    throw e;
                }
            }
        }
    }
}