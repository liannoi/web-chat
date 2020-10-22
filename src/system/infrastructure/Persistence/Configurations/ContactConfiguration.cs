using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using WebChat.Domain.Entities;

namespace WebChat.Infrastructure.Persistence.Configurations
{
    public class ContactConfiguration : IEntityTypeConfiguration<Contacts>
    {
        public void Configure(EntityTypeBuilder<Contacts> builder)
        {
            builder.HasKey(e => e.ContactId);
            builder.Property(e => e.Email).IsRequired().HasMaxLength(128);
            builder.Property(e => e.FirstName).IsRequired().HasMaxLength(64);
            builder.Property(e => e.LastName).HasMaxLength(64);
            builder.Property(e => e.Photo).HasMaxLength(256);
        }
    }
}