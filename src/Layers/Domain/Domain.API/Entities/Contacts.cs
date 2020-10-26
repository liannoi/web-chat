namespace WebChat.Domain.API.Entities
{
    public class Contacts
    {
        public int ContactId { get; set; }
        public int OwnerUserId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Photo { get; set; }
    }
}