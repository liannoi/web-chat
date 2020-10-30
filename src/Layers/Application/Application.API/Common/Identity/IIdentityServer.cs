using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Primitives;

namespace WebChat.Application.API.Common.Identity
{
    public interface IIdentityServer
    {
        string CreateToken<TUser>(TUser user) where TUser : IdentityUser;

        string ReadToken(StringValues stream);
    }
}