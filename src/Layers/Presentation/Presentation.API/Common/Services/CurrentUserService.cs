using Microsoft.AspNetCore.Http;
using WebChat.Application.API.Common.Identity;

namespace WebChat.Presentation.API.Common.Services
{
    public class CurrentUserService : ICurrentUserService
    {
        // ReSharper disable once SuggestBaseTypeForParameter
        public CurrentUserService(IHttpContextAccessor httpContextAccessor, IIdentityService identityService)
        {
            var stream = httpContextAccessor.HttpContext.Request.Headers["Authorization"];
            if (stream.Count == 0) return;

            UserId = identityService.ReadToken(stream);
        }

        public string UserId { get; }
    }
}