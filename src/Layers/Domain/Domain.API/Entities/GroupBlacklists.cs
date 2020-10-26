namespace WebChat.Domain.API.Entities
{
    public class GroupBlacklists
    {
        public int GroupId { get; set; }
        public int BlockedUserId { get; set; }

        public virtual Groups Group { get; set; }
    }
}