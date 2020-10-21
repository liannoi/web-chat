using System;
using System.Collections.Generic;

namespace WebChat.Infrastructure.Models
{
    public partial class GroupBlacklists
    {
        public int GroupId { get; set; }
        public int BlockedUserId { get; set; }

        public virtual Groups Group { get; set; }
    }
}
