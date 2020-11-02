using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebChat.Application.API.Storage.ConversationMessages.Conversation.Queries;
using WebChat.Application.API.Storage.ConversationMessages.Core.Models;
using WebChat.Presentation.API.Common;

namespace WebChat.Presentation.API.Controllers.ConversationMessages
{
    public class CrimeaController : BaseController
    {
        [HttpGet("{id}")]
        public async Task<ActionResult<DetailsViewModel>> GetById(int id)
        {
            return Ok(await Mediator.Send(new DetailsQuery {ConversationId = id}));
        }
    }
}