using System.Security.Claims;
using Microsoft.AspNetCore.Http;
using WebChat.Application.API.Common.Interfaces;

namespace WebChat.Presentation.API.Services
{
    public class CurrentUserService : ICurrentUserService
    {
        public CurrentUserService(IHttpContextAccessor httpContextAccessor)
        {
            UserId = httpContextAccessor.HttpContext.User.FindFirstValue(ClaimTypes.NameIdentifier);
        }

        public string UserId { get; }
    }
}