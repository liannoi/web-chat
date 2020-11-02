using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using WebChat.Application.API.Storage.Users.Core.Commands.Login;
using WebChat.Application.API.Storage.Users.Core.Commands.Signup;
using WebChat.Application.API.Storage.Users.Core.Commands.Verify;
using WebChat.Application.API.Storage.Users.Core.Models;
using WebChat.Presentation.API.Common;

namespace WebChat.Presentation.API.Controllers.Users
{
    public class UsersController : BaseController
    {
        [HttpPost("signup")]
        public async Task<ActionResult<JwtToken>> Signup([FromBody] SignupCommand command)
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