using System.Collections.Generic;

namespace WebChat.Application.API.Storage.Contacts.Core.Models
{
    public class ListViewModel
    {
        public IList<DetailsViewModel> Contacts { get; set; }
    }
}