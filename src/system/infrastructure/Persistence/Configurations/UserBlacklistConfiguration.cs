using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using WebChat.Domain.Entities;

namespace WebChat.Infrastructure.Persistence.Configurations
{
    public class UserBlacklistConfiguration : IEntityTypeConfiguration<UserBlacklists>
    {
        public void Configure(EntityTypeBuilder<UserBlacklists> builder)
        {
            builder.HasKey(e => new {e.OwnerUserId, e.BlockedUserId});
        }
    }
}