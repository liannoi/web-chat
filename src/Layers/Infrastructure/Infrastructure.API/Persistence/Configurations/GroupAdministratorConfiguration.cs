using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using WebChat.Domain.API.Entities;

namespace WebChat.Infrastructure.API.Persistence.Configurations
{
    public class GroupAdministratorConfiguration : IEntityTypeConfiguration<GroupAdministrators>
    {
        public void Configure(EntityTypeBuilder<GroupAdministrators> builder)
        {
            builder.HasKey(e => new {e.GroupId, e.AdministratorUserId});

            builder.HasOne(d => d.Group)
                .WithMany(p => p.GroupAdministrators)
                .HasForeignKey(d => d.GroupId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_GroupAdministrators_GroupId");
        }
    }
}