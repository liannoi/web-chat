using System.Reflection;
using Microsoft.EntityFrameworkCore;
using WebChat.Application.API.Common.Interfaces;
using WebChat.Domain.API.Entities;

namespace WebChat.Infrastructure.API.Persistence
{
    public class WebChatContext : DbContext, IWebChatContext
    {
        public WebChatContext(DbContextOptions<WebChatContext> options) : base(options)
        {
        }

        public DbSet<Contacts> Contacts { get; set; }
        public DbSet<ConversationMessages> ConversationMessages { get; set; }
        public DbSet<Conversations> Conversations { get; set; }
        public DbSet<GroupAdministrators> GroupAdministrators { get; set; }
        public DbSet<GroupBlacklists> GroupBlacklists { get; set; }
        public DbSet<GroupMessages> GroupMessages { get; set; }
        public DbSet<Groups> Groups { get; set; }
        public DbSet<UserBlacklists> UserBlacklists { get; set; }
        public DbSet<UserGroups> UserGroups { get; set; }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());

            base.OnModelCreating(builder);
        }
    }
}