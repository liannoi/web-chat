using System;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using Microsoft.AspNetCore.Http;
using WebChat.Application.API.Common.Identity;
using WebChat.Application.API.Common.Interfaces;

namespace WebChat.Presentation.API.Services
{
    public class CurrentUserService : ICurrentUserService
    {
        public CurrentUserService(IHttpContextAccessor httpContextAccessor)
        {
            var stream = httpContextAccessor.HttpContext.Request.Headers["Authorization"];
            if (stream.Count == 0)
            {
                return;
            }
            var handler = new JwtSecurityTokenHandler();
            JwtSecurityToken tokenS;
            try
            {
                 tokenS = handler.ReadJwtToken(stream.ToString().Replace("Bearer ", string.Empty));
            }
            catch (ArgumentException)
            {
                throw new UnauthorizedAccessException();
            }
            
            var jwi = tokenS.Subject;
            UserId = jwi;
        }

        public string UserId { get; }
    }
}