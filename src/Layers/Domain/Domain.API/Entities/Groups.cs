using System.Collections.Generic;

namespace WebChat.Domain.API.Entities
{
    public class Groups
    {
        public Groups()
        {
            GroupAdministrators = new HashSet<GroupAdministrators>();
            GroupBlacklists = new HashSet<GroupBlacklists>();
            GroupMessages = new HashSet<GroupMessages>();
            UserGroups = new HashSet<UserGroups>();
        }

        public int GroupId { get; set; }
        public string Name { get; set; }

        public virtual ICollection<GroupAdministrators> GroupAdministrators { get; set; }
        public virtual ICollection<GroupBlacklists> GroupBlacklists { get; set; }
        public virtual ICollection<GroupMessages> GroupMessages { get; set; }
        public virtual ICollection<UserGroups> UserGroups { get; set; }
    }
}