namespace WebChat.Domain.Entities
{
    public class GroupAdministrators
    {
        public int GroupId { get; set; }
        public int AdministratorUserId { get; set; }

        public virtual Groups Group { get; set; }
    }
}