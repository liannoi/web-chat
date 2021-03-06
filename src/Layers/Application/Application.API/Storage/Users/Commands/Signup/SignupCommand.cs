using System;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using WebChat.Application.API.Common.Interfaces;
using WebChat.Application.API.Storage.Users.Models;

namespace WebChat.Application.API.Storage.Users.Commands.Signup
{
    public class SignupCommand : IRequest<JwtToken>
    {
        public string UserName { get; set; }
        public string Password { get; set; }

        private class Handler : IRequestHandler<SignupCommand, JwtToken>
        {
            private readonly IIdentityService _identityService;

            public Handler(IIdentityService identityService)
            {
                _identityService = identityService;
            }

            public async Task<JwtToken> Handle(SignupCommand request, CancellationToken cancellationToken)
            {
                var (result, token) = await _identityService.Signup(request.UserName, request.Password);
                if (!result.Succeeded) throw new UnauthorizedAccessException(result.Errors[0]);

                return token;
            }
        }
    }
}