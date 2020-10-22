using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using WebChat.Domain.Entities;

namespace WebChat.Infrastructure.Persistence.Configurations
{
    public class ConversationMessageConfiguration : IEntityTypeConfiguration<ConversationMessages>
    {
        public void Configure(EntityTypeBuilder<ConversationMessages> builder)
        {
            builder.HasKey(e => e.ConversationMessageId);
            builder.Property(e => e.Message).IsRequired().HasMaxLength(1024);

            builder.HasOne(d => d.Conversation)
                .WithMany(p => p.ConversationMessages)
                .HasForeignKey(d => d.ConversationId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ConversationMessages_ConversationId");
        }
    }
}