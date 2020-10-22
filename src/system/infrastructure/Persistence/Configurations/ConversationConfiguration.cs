using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using WebChat.Domain.Entities;

namespace WebChat.Infrastructure.Persistence.Configurations
{
    public class ConversationConfiguration : IEntityTypeConfiguration<Conversations>
    {
        public void Configure(EntityTypeBuilder<Conversations> builder)
        {
            builder.HasKey(e => e.ConversationId);
        }
    }
}