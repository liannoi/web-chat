using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebChat.Application.API.Storage.Contacts.Commands.Create;
using WebChat.Presentation.API.Common;

namespace WebChat.Presentation.API.Controllers.Conversations
{
    public class ConversationsController : BaseController
    {
        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CreateCommand command)
        {
            return Ok(await Mediator.Send(command));
        }
    }
}