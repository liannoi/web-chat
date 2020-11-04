using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebChat.Application.API.Storage.Conversations.Models;
using WebChat.Application.API.Storage.Conversations.Queries;
using WebChat.Presentation.API.Common;

namespace WebChat.Presentation.API.Controllers.Conversations
{
    public class CoalerController : BaseController
    {
        [HttpGet("{id}")]
        public async Task<ActionResult<ListViewModel>> GetAll(int id)
        {
            return Ok(await Mediator.Send(new LeftOrRightListQuery {UserId = id}));
        }
    }
}