using System;
using System.Collections.Generic;

namespace WebChat.Infrastructure.Models
{
    public partial class GroupMessages
    {
        public int GroupMessageId { get; set; }
        public int GroupId { get; set; }
        public string Message { get; set; }

        public virtual Groups Group { get; set; }
    }
}
