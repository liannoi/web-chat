using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace WebChat.Infrastructure.API.Identity
{
    public class WebChatIdentityContext : IdentityDbContext<ApplicationUser>
    {
        public WebChatIdentityContext(DbContextOptions<WebChatIdentityContext> options) : base(options)
        {
        }
    }
}