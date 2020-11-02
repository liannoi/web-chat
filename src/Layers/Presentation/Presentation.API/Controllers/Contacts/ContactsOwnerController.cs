using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebChat.Application.API.Storage.Contacts.Core.Models;
using WebChat.Application.API.Storage.Contacts.Owner.Queries;
using WebChat.Presentation.API.Common;

namespace WebChat.Presentation.API.Controllers.Contacts
{
    public class ContactsOwnerController : BaseController
    {
        [HttpGet("{id}")]
        public async Task<ActionResult<ListViewModel>> GetAll(int id)
        {
            return Ok(await Mediator.Send(new ListQuery {OwnerUserId = id}));
        }
    }
}