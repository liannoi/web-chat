using System;
using System.Collections.Generic;

namespace WebChat.Infrastructure.Models
{
    public partial class UserGroups
    {
        public int GroupId { get; set; }
        public int UserId { get; set; }

        public virtual Groups Group { get; set; }
    }
}
