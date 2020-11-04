using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebChat.Application.API.Storage.ConversationMessages.Models;
using WebChat.Application.API.Storage.ConversationMessages.Queries;
using WebChat.Presentation.API.Common;

namespace WebChat.Presentation.API.Controllers.ConversationMessages
{
    public class CrimeaController : BaseController
    {
        [HttpGet("getById/{id}")]
        public async Task<ActionResult<ListViewModel>> GetById(int id)
        {
            return Ok(await Mediator.Send(new ConversationDetailsQuery {ConversationId = id}));
        }

        [HttpGet("getAll/{id}")]
        public async Task<ActionResult<DetailsViewModel>> GetAll(int id)
        {
            return Ok(await Mediator.Send(new ConversationListQuery {ConversationId = id}));
        }
    }
}