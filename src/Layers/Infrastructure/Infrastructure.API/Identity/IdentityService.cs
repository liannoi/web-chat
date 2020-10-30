using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using WebChat.Application.API.Common.Identity;
using WebChat.Application.API.Storage.Users.Identity.Models;
using WebChat.Infrastructure.API.Identity.Server;
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

        public async Task<string> GetUserNameAsync(string userId)
        {
            var user = await GetUserAsync(userId);

            return user.UserName;
        }

        public async Task<(IdentityResult Result, JwtToken Token)> GetUserAsync(string userName, string password)
        {
            var user = await _manager.FindByNameAsync(userName);
            var isChecked = await _manager.CheckPasswordAsync(user, password);

            if (user == null || !isChecked) throw new UnauthorizedAccessException();

            return (IdentityResult.Success(), new JwtToken {Value = CreateToken(user)});
        }

        public async Task<bool> UserIsInRole(string userId, string role)
        {
            var user = await GetUserAsync(userId);

            return await _manager.IsInRoleAsync(user, role);
        }

        public async Task<(IdentityResult Result, JwtToken Token)> CreateUserAsync(string userName, string password)
        {
            var user = new ApplicationUser {UserName = userName, Email = userName};
            var result = await _manager.CreateAsync(user, password);

            return (result.ToApplicationResult(), new JwtToken {Value = CreateToken(user)});
        }

        public async Task<IdentityResult> DeleteUserAsync(string userId)
        {
            var user = await GetUserAsync(userId);

            if (user != null) return await DeleteUserAsync(user);

            return IdentityResult.Success();
        }

        // Helpers.

        private async Task<ApplicationUser> GetUserAsync(string userId)
        {
            return await _manager.Users.SingleOrDefaultAsync(u => u.Id == userId);
        }

        private async Task<IdentityResult> DeleteUserAsync(ApplicationUser user)
        {
            var result = await _manager.DeleteAsync(user);

            return result.ToApplicationResult();
        }
    }
}