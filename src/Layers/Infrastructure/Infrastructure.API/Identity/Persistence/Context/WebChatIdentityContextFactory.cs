using Microsoft.EntityFrameworkCore;

namespace WebChat.Infrastructure.API.Identity.Persistence.Context
{
    public class WebChatIdentityContextFactory : DesignTimeDbContextFactoryBase<WebChatIdentityContext>
    {
        protected override WebChatIdentityContext CreateNewInstance(DbContextOptions<WebChatIdentityContext> options)
        {
            return new WebChatIdentityContext(options, new OperationalStoreOptionsMigrations());
        }
    }
}