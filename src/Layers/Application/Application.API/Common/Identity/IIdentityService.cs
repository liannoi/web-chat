using System.Threading.Tasks;
using WebChat.Application.API.Storage.Users.Models;
using WebChat.Domain.API.Identity;

namespace WebChat.Application.API.Common.Identity
{
    public interface IIdentityService : IIdentityServer<ApplicationUser, int>
    {
        Task<ApplicationUser> GetUserAsync(string username);

        Task<ApplicationUser> GetUserAsync(int userId);

        Task<(IdentityResult Result, JwtToken Token)> Login(string username, string password);

        Task<(IdentityResult Result, JwtToken Token)> Signup(string username, string password);

        Task<bool> UserIsInRole(string username, string role);
    }
}