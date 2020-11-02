using System;

namespace WebChat.Domain.API.Entities
{
    public class GroupMessages
    {
        public int GroupMessageId { get; set; }
        public int GroupId { get; set; }
        public int OwnerUserId { get; set; }
        public string Message { get; set; }
        public DateTime Publish { get; set; }

        public virtual Groups Group { get; set; }
    }
}