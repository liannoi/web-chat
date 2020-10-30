using System.Threading.Tasks;
using WebChat.Application.API.Storage.Users.Identity.Models;
using WebChat.Domain.API.Entities.Identity;

namespace WebChat.Application.API.Common.Identity
{
    public interface IIdentityService : IIdentityServer
    {
        Task<string> GetUserNameAsync(string userId);

        Task<(IdentityResult Result, JwtToken Token)> GetUserAsync(string userName, string password);

        Task<ApplicationUser> GetUserAsync(string userName);

        Task<bool> UserIsInRole(string userId, string role);

        Task<(IdentityResult Result, JwtToken Token)> CreateUserAsync(string userName, string password);

        Task<IdentityResult> DeleteUserAsync(string userId);
    }
}