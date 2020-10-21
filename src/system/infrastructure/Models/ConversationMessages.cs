using System;
using System.Collections.Generic;

namespace WebChat.Infrastructure.Models
{
    public partial class ConversationMessages
    {
        public int ConversationMessageId { get; set; }
        public int ConversationId { get; set; }
        public string Message { get; set; }

        public virtual Conversations Conversation { get; set; }
    }
}
