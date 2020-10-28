using Microsoft.AspNetCore.Identity;

namespace WebChat.Infrastructure.API.Identity.Common.Server
{
    public interface IIdentityServer
    {
        string CreateToken<TUser>(TUser user) where TUser : IdentityUser;
    }
}