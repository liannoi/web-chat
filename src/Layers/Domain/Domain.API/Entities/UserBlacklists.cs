﻿namespace WebChat.Domain.API.Entities
{
    public class UserBlacklists
    {
        public int OwnerUserId { get; set; }
        public int BlockedUserId { get; set; }
    }
}