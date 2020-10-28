using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebChat.Application.API.Storage.Users.Identity.Commands.Create;
using WebChat.Application.API.Storage.Users.Identity.Commands.Login;

namespace WebChat.Presentation.API.Controllers
{
    public class UsersController : BaseController
    {
        [HttpPost("signup")]
        public async Task<ActionResult<string>> Signup([FromBody] SignupCommand command)
        {
            return Ok(await Mediator.Send(command));
        }

        [HttpPost("login")]
        public async Task<ActionResult<string>> Login([FromBody]LoginCommand command )
        {
            return Ok(await Mediator.Send(command));
        }
    }
}