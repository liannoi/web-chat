using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using WebChat.Application.API.Storage.Contacts.Commands.Create;
using WebChat.Application.API.Storage.Contacts.Commands.Delete;
using WebChat.Application.API.Storage.Contacts.Commands.Update;
using WebChat.Application.API.Storage.Contacts.Models;
using WebChat.Application.API.Storage.Contacts.Queries.Details;
using WebChat.Application.API.Storage.Contacts.Queries.List;

namespace WebChat.Presentation.API.Controllers
{
    public class ContactsController : BaseController
    {
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        public async Task<ActionResult<ListViewModel>> GetAll()
        {
            return Ok(await Mediator.Send(new ListQuery()));
        }

        [HttpPost]
        public async Task<ActionResult<int>> Create([FromBody] CreateCommand command)
        {
            return Ok(await Mediator.Send(command));
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<DetailsViewModel>> GetById(int id)
        {
            return Ok(await Mediator.Send(new DetailsQuery {ContactId = id}));
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<DetailsViewModel>> Update(int id, [FromBody] UpdateCommand command)
        {
            command.ContactId = id;

            return Ok(await Mediator.Send(command));
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            return Ok(await Mediator.Send(new DeleteCommand {ContactId = id}));
        }
    }
}