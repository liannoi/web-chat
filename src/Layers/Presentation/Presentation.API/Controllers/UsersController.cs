using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebChat.Application.API.Storage.Users.Identity.Commands.Login;
using WebChat.Application.API.Storage.Users.Identity.Commands.Signup;
using WebChat.Application.API.Storage.Users.Identity.Commands.Verify;
using WebChat.Application.API.Storage.Users.Identity.Models;

namespace WebChat.Presentation.API.Controllers
{
    public class UsersController : BaseController
    {
        [HttpPost("signup")]
        public async Task<ActionResult<JwtToken>> Signup([FromBody] SignupCommand command)
        {
            return Ok(await Mediator.Send(command));
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginCommand command)
        {
            try
            {
                return Ok(await Mediator.Send(command));
            }
            catch (UnauthorizedAccessException e)
            {
                return Unauthorized(e.Message);
            }
        }

        [HttpPost("verify")]
        public async Task<IActionResult> Verify([FromBody] VerifyCommand command)
        {
            try
            {
                return Ok(await Mediator.Send(command));
            }
            catch (UnauthorizedAccessException e)
            {
                return Unauthorized(e.Message);
            }
        }
    }
}