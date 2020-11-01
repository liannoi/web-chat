using System.Threading;
using System.Threading.Tasks;
using MediatR;
using WebChat.Application.API.Common.Identity;
using WebChat.Application.API.Storage.Users.Core.Models;

namespace WebChat.Application.API.Storage.Users.Core.Commands.Verify
{
    [Authorize]
    public class VerifyCommand : IRequest<DetailsViewModel>
    {
        public string Value { get; set; }

        private class Handler : IRequestHandler<VerifyCommand, DetailsViewModel>
        {
            private readonly IIdentityService _identityService;

            public Handler(IIdentityService identityService)
            {
                _identityService = identityService;
            }

            public async Task<DetailsViewModel> Handle(VerifyCommand request, CancellationToken cancellationToken)
            {
                var userName = _identityService.ReadToken(request.Value);
                var user = await _identityService.GetUserAsync(userName);

                return new DetailsViewModel
                {
                    UserId = user.Id,
                    UserName = user.UserName
                };
            }
        }
    }
}