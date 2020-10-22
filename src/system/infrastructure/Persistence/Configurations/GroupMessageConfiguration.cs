using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using WebChat.Domain.Entities;

namespace WebChat.Infrastructure.Persistence.Configurations
{
    public class GroupMessageConfiguration : IEntityTypeConfiguration<GroupMessages>
    {
        public void Configure(EntityTypeBuilder<GroupMessages> builder)
        {
            builder.HasKey(e => e.GroupMessageId);
            builder.Property(e => e.Message).IsRequired().HasMaxLength(1024);

            builder.HasOne(d => d.Group)
                .WithMany(p => p.GroupMessages)
                .HasForeignKey(d => d.GroupId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_GroupMessages_GroupId");
        }
    }
}