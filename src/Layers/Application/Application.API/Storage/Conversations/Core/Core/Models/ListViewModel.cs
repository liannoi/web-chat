using System.Collections.Generic;

namespace WebChat.Application.API.Storage.Conversations.Core.Core.Models
{
    public class ListViewModel
    {
        public IList<DetailsViewModel> Conversations { get; set; }
    }
}