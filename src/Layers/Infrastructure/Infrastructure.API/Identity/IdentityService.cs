using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using WebChat.Application.API.Common.Interfaces;
using WebChat.Application.API.Common.Models;
using WebChat.Infrastructure.API.Identity.Persistence;

namespace WebChat.Infrastructure.API.Identity
{
    public class IdentityService : IIdentityService
    {
        private readonly UserManager<ApplicationUser> _manager;

        public IdentityService(UserManager<ApplicationUser> manager)
        {
            _manager = manager;
        }

        public async Task<string> GetUserNameAsync(string userId)
        {
            var user = await GetUserAsync(userId);

            return user.UserName;
        }

        public async Task<bool> UserIsInRole(string userId, string role)
        {
            var user = await GetUserAsync(userId);

            return await _manager.IsInRoleAsync(user, role);
        }

        public async Task<(IdenitityResult Result, string UserId)> CreateUserAsync(string userName, string password)
        {
            var user = new ApplicationUser {UserName = userName, Email = userName};
            var result = await _manager.CreateAsync(user, password);

            return (result.ToApplicationResult(), user.Id);
        }

        public async Task<IdenitityResult> DeleteUserAsync(string userId)
        {
            var user = await GetUserAsync(userId);

            if (user != null) return await DeleteUserAsync(user);

            return IdenitityResult.Success();
        }

        private async Task<ApplicationUser> GetUserAsync(string userId)
        {
            return await _manager.Users.SingleOrDefaultAsync(u => u.Id == userId);
        }

        private async Task<IdenitityResult> DeleteUserAsync(ApplicationUser user)
        {
            var result = await _manager.DeleteAsync(user);

            return result.ToApplicationResult();
        }
    }
}