using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebChat.Application.API.Storage.Contacts.Commands.Create;
using WebChat.Application.API.Storage.Contacts.Models;
using WebChat.Application.API.Storage.Contacts.Queries.List;

namespace WebChat.Presentation.API.Controllers
{
    public class ContactsController : BaseController
    {
        [HttpGet]
        public async Task<ActionResult<ListViewModel>> GetAll()
        {
            return Ok(await Mediator.Send(new ListQuery()));
        }

        [HttpPost]
        public async Task<ActionResult<DetailsViewModel>> Create([FromBody] CreateCommand command)
        {
            return Ok(await Mediator.Send(command));
        }

        [HttpGet("{id}")]
        public IActionResult GetById()
        {
            return Ok();
        }

        [HttpPut("{id}")]
        public IActionResult Update(int id)
        {
            return Ok();
        }

        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            return Ok();
        }
    }
}