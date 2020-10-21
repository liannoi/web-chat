using System;
using System.Collections.Generic;

namespace WebChat.Infrastructure.Models
{
    public partial class UserBlacklists
    {
        public int OwnerUserId { get; set; }
        public int BlockedUserId { get; set; }
    }
}
