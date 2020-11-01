using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebChat.Application.API.Storage.Contacts.Models;
using WebChat.Application.API.Storage.Contacts.Owner.Queries.Details;

namespace WebChat.Presentation.API.Controllers
{
    public class ContactsOwnerController : BaseController
    {
        [HttpGet("{id}")]
        public async Task<ActionResult<ListViewModel>> GetById(int id)
        {
            return Ok(await Mediator.Send(new DetailsQuery {OwnerUserId = id}));
        }
    }
}