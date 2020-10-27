using IdentityServer4.EntityFramework.Options;
using Microsoft.AspNetCore.ApiAuthorization.IdentityServer;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;

namespace WebChat.Infrastructure.API.Identity.Persistence.Context
{
    public class WebChatIdentityContext : ApiAuthorizationDbContext<ApplicationUser>
    {
        public WebChatIdentityContext(DbContextOptions<WebChatIdentityContext> options,
            IOptions<OperationalStoreOptions> operationalStoreOptions) : base(options, operationalStoreOptions)
        {
        }
    }
}