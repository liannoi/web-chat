using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using WebChat.Domain.API.Entities.Identity;

namespace WebChat.Infrastructure.API.Identity
{
    public class WebChatIdentityContext : IdentityDbContext<ApplicationUser, IdentityRole<int>, int>
    {
        public WebChatIdentityContext(DbContextOptions<WebChatIdentityContext> options) : base(options)
        {
        }
    }
}