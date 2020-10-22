using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using WebChat.Domain.Entities;

namespace WebChat.Infrastructure.Persistence.Configurations
{
    public class UserGroupConfiguration : IEntityTypeConfiguration<UserGroups>
    {
        public void Configure(EntityTypeBuilder<UserGroups> builder)
        {
            builder.HasKey(e => new {e.GroupId, e.UserId});

            builder.HasOne(d => d.Group)
                .WithMany(p => p.UserGroups)
                .HasForeignKey(d => d.GroupId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("PK_UserGroups_GroupId");
        }
    }
}