using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebChat.Application.API.Storage.ConversationMessages.Conversation.Queries;
using WebChat.Application.API.Storage.ConversationMessages.Core.Models;
using WebChat.Presentation.API.Common;

namespace WebChat.Presentation.API.Controllers.ConversationMessages
{
    public class CrimeaController : BaseController
    {
        [HttpGet("getById/{id}")]
        public async Task<ActionResult<ListViewModel>> GetById(int id)
        {
            return Ok(await Mediator.Send(new DetailsQuery {ConversationId = id}));
        }

        [HttpGet("getAll/{id}")]
        public async Task<ActionResult<DetailsViewModel>> GetAll(int id)
        {
            return Ok(await Mediator.Send(new ListQuery {ConversationId = id}));
        }
    }
}