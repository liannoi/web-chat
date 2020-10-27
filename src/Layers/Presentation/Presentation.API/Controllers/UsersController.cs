using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebChat.Application.API.Storage.Users.Identity.Commands.Create;

namespace WebChat.Presentation.API.Controllers
{
    public class UsersController : BaseController
    {
        [HttpPost]
        public async Task<IActionResult> Create([FromBody] CreateCommand command)
        {
            return Ok(await Mediator.Send(command));
        }
    }
}