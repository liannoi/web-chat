using System.Linq;
using IdentityResult = WebChat.Application.API.Common.Identity.IdentityResult;

namespace WebChat.Infrastructure.API.Identity.Common.Extensions
{
    public static class IdentityResultExtensions
    {
        public static IdentityResult ToApplicationResult(this Microsoft.AspNetCore.Identity.IdentityResult result)
        {
            return result.Succeeded
                ? IdentityResult.Success()
                : IdentityResult.Failure(result.Errors.Select(e => e.Description));
        }
    }
}