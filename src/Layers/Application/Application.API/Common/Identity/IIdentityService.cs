using System.Threading.Tasks;
using WebChat.Application.API.Storage.Users.Identity.Models;

namespace WebChat.Application.API.Common.Identity
{
    public interface IIdentityService
    {
        Task<string> GetUserNameAsync(string userId);

        Task<(IdentityResult Result, JwtToken Token)> GetUserAsync(string userName, string password);

        Task<bool> UserIsInRole(string userId, string role);

        Task<(IdentityResult Result, JwtToken Token)> CreateUserAsync(string userName, string password);

        Task<IdentityResult> DeleteUserAsync(string userId);
    }
}