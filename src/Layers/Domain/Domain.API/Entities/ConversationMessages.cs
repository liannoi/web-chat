namespace WebChat.Domain.API.Entities
{
    public class ConversationMessages
    {
        public int ConversationMessageId { get; set; }
        public int ConversationId { get; set; }
        public string Message { get; set; }

        public virtual Conversations Conversation { get; set; }
    }
}