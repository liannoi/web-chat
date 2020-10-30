using Microsoft.AspNetCore.Identity;

namespace WebChat.Infrastructure.API.Identity.Server
{
    public interface IIdentityServer
    {
        string CreateToken<TUser>(TUser user) where TUser : IdentityUser;
    }
}