using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using WebChat.Domain.API.Entities;

namespace WebChat.Infrastructure.API.Persistence.Configurations
{
    public class GroupBlacklistConfiguration : IEntityTypeConfiguration<GroupBlacklists>
    {
        public void Configure(EntityTypeBuilder<GroupBlacklists> builder)
        {
            builder.HasKey(e => new {e.GroupId, e.BlockedUserId});

            builder.HasOne(d => d.Group)
                .WithMany(p => p.GroupBlacklists)
                .HasForeignKey(d => d.GroupId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_GroupBlacklists_GroupId");
        }
    }
}