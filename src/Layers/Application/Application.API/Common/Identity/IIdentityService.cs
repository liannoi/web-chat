using System.Threading.Tasks;

namespace WebChat.Application.API.Common.Identity
{
    public interface IIdentityService
    {
        Task<string> GetUserNameAsync(string userId);

        Task<(IdentityResult Result, string Token)> GetUserAsync(string userName, string password);

        Task<bool> UserIsInRole(string userId, string role);

        Task<(IdentityResult Result, string Token)> CreateUserAsync(string userName, string password);

        Task<IdentityResult> DeleteUserAsync(string userId);
    }
}