using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using WebChat.Infrastructure.API.Identity.Common.Models;

namespace WebChat.Infrastructure.API.Identity
{
    public class WebChatIdentityContext : IdentityDbContext<ApplicationUser>
    {
        public WebChatIdentityContext(DbContextOptions<WebChatIdentityContext> options) : base(options)
        {
        }
    }
}