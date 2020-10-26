using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using WebChat.Domain.API.Entities;

namespace WebChat.Infrastructure.API.Persistence.Configurations
{
    public class ConversationConfiguration : IEntityTypeConfiguration<Conversations>
    {
        public void Configure(EntityTypeBuilder<Conversations> builder)
        {
            builder.HasKey(e => e.ConversationId);
        }
    }
}