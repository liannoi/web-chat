using System;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Primitives;
using WebChat.Application.API.Common.Identity;

namespace WebChat.Presentation.API.Common.Services
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
            try
            {
                return new JwtSecurityTokenHandler().ReadJwtToken(stream.ToString().Replace("Bearer ", string.Empty))
                    .Subject;
            }
            catch (ArgumentException)
            {
                throw new UnauthorizedAccessException();
            }
        }
    }
}