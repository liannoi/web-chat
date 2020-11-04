using System.Collections.Generic;

namespace WebChat.Application.API.Storage.Conversations.Models
{
    public class ListViewModel
    {
        public IList<DetailsViewModel> Conversations { get; set; }
    }
}