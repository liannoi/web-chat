namespace WebChat.Domain.API.Entities
{
    public class UserGroups
    {
        public int GroupId { get; set; }
        public int UserId { get; set; }

        public virtual Groups Group { get; set; }
    }
}