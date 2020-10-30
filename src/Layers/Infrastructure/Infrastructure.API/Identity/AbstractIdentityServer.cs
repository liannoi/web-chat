using System;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Options;
using Microsoft.Extensions.Primitives;
using Microsoft.IdentityModel.Tokens;
using WebChat.Application.API.Common.Identity;

namespace WebChat.Infrastructure.API.Identity
{
    public abstract class AbstractIdentityServer : IIdentityServer
    {
        private readonly IdentitySettings _settings;

        protected AbstractIdentityServer(IOptions<IdentitySettings> settings)
        {
            _settings = settings.Value;
        }

        public string CreateToken<TUser>(TUser user) where TUser : IdentityUser
        {
            return new JwtSecurityTokenHandler().WriteToken(PrepareToken(user));
        }

        public string ReadToken(StringValues stream)
        {
            try
            {
                var token = new JwtSecurityTokenHandler().ReadJwtToken(stream.ToString()
                    .Replace("Bearer ", string.Empty));

                if (token.ValidTo.AddHours(2) <= DateTime.Now) throw new UnauthorizedAccessException();

                return token.Subject;
            }
            catch (ArgumentException)
            {
                throw new UnauthorizedAccessException();
            }
        }

        private JwtSecurityToken PrepareToken(IdentityUser user)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_settings.Secret));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Sub, user.UserName),
                new Claim(JwtRegisteredClaimNames.Email, user.Email),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
            };

            var expires = DateTime.Now.AddMinutes(15);
            var issuer = _settings.Issuer;

            return new JwtSecurityToken(issuer, issuer, claims, expires: expires, signingCredentials: credentials);
        }
    }
}