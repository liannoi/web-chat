using Microsoft.EntityFrameworkCore;
using WebChat.Infrastructure.API.Identity;

namespace WebChat.Infrastructure.API.Factory
{
    public class WebChatIdentityContextFactory : AbstractDbContextFactory<WebChatIdentityContext>
    {
        protected override WebChatIdentityContext CreateNewInstance(DbContextOptions<WebChatIdentityContext> options)
        {
            return new WebChatIdentityContext(options);
        }
    }
}