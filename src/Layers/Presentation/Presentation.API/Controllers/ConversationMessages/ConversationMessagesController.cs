using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebChat.Application.API.Storage.ConversationMessages.Core.Commands.Create;
using WebChat.Presentation.API.Common;

namespace WebChat.Presentation.API.Controllers.ConversationMessages
{
    public class ConversationMessagesController : BaseController
    {
        [HttpPost]
        public async Task<IActionResult> Create(CreateCommand command)
        {
            return Ok(await Mediator.Send(command));
        }
    }
}