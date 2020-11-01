using System;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Primitives;

namespace WebChat.Application.API.Common.Identity
{
    public interface IIdentityServer<in TUser, out TKey> where TUser : IdentityUser<TKey> where TKey : IEquatable<TKey>
    {
        string CreateToken(TUser user);

        string ReadToken(StringValues stream);
    }
}