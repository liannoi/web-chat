using System.Threading.Tasks;
using WebChat.Application.Common.Models;

namespace WebChat.Application.Common.Interfaces
{
    public interface IIdentityService
    {
        Task<string> GetUserNameAsync(string userId);

        Task<bool> UserIsInRole(string userId, string role);

        Task<(TupleResult Result, string UserId)> CreateUserAsync(string userName, string password);

        Task<TupleResult> DeleteUserAsync(string userId);
    }
}