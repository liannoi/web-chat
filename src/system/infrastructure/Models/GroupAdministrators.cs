using System;
using System.Collections.Generic;

namespace WebChat.Infrastructure.Models
{
    public partial class GroupAdministrators
    {
        public int GroupId { get; set; }
        public int AdministratorUserId { get; set; }

        public virtual Groups Group { get; set; }
    }
}
