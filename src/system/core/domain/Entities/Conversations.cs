using System.Collections.Generic;

namespace WebChat.Domain.Entities
{
    public class Conversations
    {
        public Conversations()
        {
            ConversationMessages = new HashSet<ConversationMessages>();
        }

        public int ConversationId { get; set; }
        public int LeftUserId { get; set; }
        public int RightUserId { get; set; }

        public virtual ICollection<ConversationMessages> ConversationMessages { get; set; }
    }
}