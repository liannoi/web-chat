using System.Threading;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using WebChat.Domain.API.Entities;

namespace WebChat.Application.API.Common.Interfaces
{
    public interface IWebChatContext
    {
        public DbSet<Contacts> Contacts { get; set; }

        public DbSet<ConversationMessages> ConversationMessages { get; set; }

        public DbSet<Conversations> Conversations { get; set; }

        public DbSet<GroupAdministrators> GroupAdministrators { get; set; }

        public DbSet<GroupBlacklists> GroupBlacklists { get; set; }

        public DbSet<GroupMessages> GroupMessages { get; set; }

        public DbSet<Groups> Groups { get; set; }

        public DbSet<UserBlacklists> UserBlacklists { get; set; }

        public DbSet<UserGroups> UserGroups { get; set; }

        Task<int> SaveChangesAsync(CancellationToken cancellationToken);
    }
}