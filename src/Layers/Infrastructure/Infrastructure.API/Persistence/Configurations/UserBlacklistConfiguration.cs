using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using WebChat.Domain.API.Entities;

namespace WebChat.Infrastructure.API.Persistence.Configurations
{
    public class UserBlacklistConfiguration : IEntityTypeConfiguration<UserBlacklists>
    {
        public void Configure(EntityTypeBuilder<UserBlacklists> builder)
        {
            builder.HasKey(e => new {e.OwnerUserId, e.BlockedUserId});
        }
    }
}