using System.Collections.Generic;

namespace WebChat.Application.API.Storage.ConversationMessages.Core.Models
{
    public class ListViewModel
    {
        public IList<DetailsViewModel> Messages { get; set; }
    }
}