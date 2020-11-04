using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebChat.Application.API.Storage.Contacts.Models;
using WebChat.Application.API.Storage.Contacts.Queries;
using WebChat.Presentation.API.Common;

namespace WebChat.Presentation.API.Controllers.Contacts
{
    public class ContactsOwnerController : BaseController
    {
        [HttpGet("{id}")]
        public async Task<ActionResult<ListViewModel>> GetAll(int id)
        {
            return Ok(await Mediator.Send(new OwnerListQuery {OwnerUserId = id}));
        }
    }
}