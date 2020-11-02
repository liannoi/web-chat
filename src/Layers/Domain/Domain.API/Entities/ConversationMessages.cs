using System;

namespace WebChat.Domain.API.Entities
{
    public class ConversationMessages
    {
        public int ConversationMessageId { get; set; }
        public int ConversationId { get; set; }
        public int OwnerUserId { get; set; }
        public string Message { get; set; }
        public DateTime Publish { get; set; }

        public virtual Conversations Conversation { get; set; }
    }
}