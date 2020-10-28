using System;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using WebChat.Infrastructure.API.Identity.Common.Models;

namespace WebChat.Infrastructure.API.Identity.Common.Server
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