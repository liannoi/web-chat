using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using WebChat.Application.API.Common.Identity;
using WebChat.Application.API.Storage.Users.Core.Models;
using WebChat.Domain.API.Entities.Identity;
using IdentityResult = WebChat.Application.API.Common.Identity.IdentityResult;

namespace WebChat.Infrastructure.API.Identity
{
    public class IdentityService : AbstractIdentityServer, IIdentityService
    {
        private readonly UserManager<ApplicationUser> _manager;

        public IdentityService(UserManager<ApplicationUser> manager, IOptions<IdentitySettings> settings) :
            base(settings)
        {
            _manager = manager;
        }

        public async Task<ApplicationUser> GetUserAsync(string username)
        {
            return await _manager.FindByNameAsync(username);
        }

        public async Task<ApplicationUser> GetUserAsync(int userId)
        {
            return await _manager.Users.SingleOrDefaultAsync(u => u.Id == userId);
        }

        public async Task<(IdentityResult Result, JwtToken Token)> Login(string username, string password)
        {
            var user = await _manager.FindByNameAsync(username);
            var isChecked = await _manager.CheckPasswordAsync(user, password);
            if (user == null || !isChecked) throw new UnauthorizedAccessException();

            return (IdentityResult.Success(), new JwtToken {Value = CreateToken(user)});
        }

        public async Task<(IdentityResult Result, JwtToken Token)> Signup(string username, string password)
        {
            var user = new ApplicationUser {UserName = username, Email = username};
            var result = await _manager.CreateAsync(user, password);

            return (result.ToApplicationResult(), new JwtToken {Value = CreateToken(user)});
        }

        public async Task<bool> UserIsInRole(string username, string role)
        {
            return await _manager.IsInRoleAsync(await GetUserAsync(username), role);
        }
    }
}