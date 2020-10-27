using System.Linq;
using Microsoft.AspNetCore.Identity;
using WebChat.Application.API.Common.Models;

namespace WebChat.Infrastructure.API.Identity
{
    public static class IdentityResultExtensions
    {
        public static IdenitityResult ToApplicationResult(this IdentityResult result)
        {
            return result.Succeeded
                ? IdenitityResult.Success()
                : IdenitityResult.Failure(result.Errors.Select(e => e.Description));
        }
    }
}