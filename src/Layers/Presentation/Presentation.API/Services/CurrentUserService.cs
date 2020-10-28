using System;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Primitives;
using WebChat.Application.API.Common.Identity;

namespace WebChat.Presentation.API.Services
{
    public class CurrentUserService : ICurrentUserService
    {
        public CurrentUserService(IHttpContextAccessor httpContextAccessor)
        {
            var stream = httpContextAccessor.HttpContext.Request.Headers["Authorization"];
            if (stream.Count == 0) return;

            UserId = ReadToken(stream);
        }

        public string UserId { get; }

        // Helpers.

        private string ReadToken(StringValues stream)
        {
            var trimmedStream = stream.ToString().Replace("Bearer ", string.Empty);

            JwtSecurityToken token;
            try
            {
                token = new JwtSecurityTokenHandler().ReadJwtToken(trimmedStream);
            }
            catch (ArgumentException)
            {
                throw new UnauthorizedAccessException();
            }

            return token.Subject;
        }
    }
}