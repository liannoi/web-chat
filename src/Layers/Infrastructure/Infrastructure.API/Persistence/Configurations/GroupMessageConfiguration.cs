using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using WebChat.Domain.API.Entities;

namespace WebChat.Infrastructure.API.Persistence.Configurations
{
    public class GroupMessageConfiguration : IEntityTypeConfiguration<GroupMessages>
    {
        public void Configure(EntityTypeBuilder<GroupMessages> builder)
        {
            builder.HasKey(e => e.GroupMessageId);
            builder.Property(e => e.Message).IsRequired().HasMaxLength(1024);
            builder.Property(e => e.Publish).HasColumnType("datetime").HasDefaultValueSql("(getdate())");

            builder.HasOne(d => d.Group)
                .WithMany(p => p.GroupMessages)
                .HasForeignKey(d => d.GroupId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_GroupMessages_GroupId");
        }
    }
}