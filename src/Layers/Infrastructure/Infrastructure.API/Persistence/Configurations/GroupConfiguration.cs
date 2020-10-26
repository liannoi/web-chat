using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using WebChat.Domain.API.Entities;

namespace WebChat.Infrastructure.API.Persistence.Configurations
{
    public class GroupConfiguration : IEntityTypeConfiguration<Groups>
    {
        public void Configure(EntityTypeBuilder<Groups> builder)
        {
            builder.HasKey(e => e.GroupId);
            builder.Property(e => e.Name).IsRequired().HasMaxLength(64);
        }
    }
}