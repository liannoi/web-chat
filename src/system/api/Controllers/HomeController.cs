using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace WebChat.Api.Controllers
{
    public class HomeController : BaseController
    {
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        public IActionResult GetAll()
        {
            return Ok("Hello");
        }
    }
}