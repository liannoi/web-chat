using System.Collections.Generic;

namespace WebChat.Application.API.Storage.ConversationMessages.Models
{
    public class ListViewModel
    {
        public IList<DetailsViewModel> Messages { get; set; }
    }
}