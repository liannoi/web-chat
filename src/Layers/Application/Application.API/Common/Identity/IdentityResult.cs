using System.Collections.Generic;
using System.Linq;

namespace WebChat.Application.API.Common.Identity
{
    public class IdentityResult
    {
        private IdentityResult(bool succeeded, IEnumerable<string> errors)
        {
            Succeeded = succeeded;
            Errors = errors.ToArray();
        }

        public bool Succeeded { get; set; }
        public string[] Errors { get; set; }

        public static IdentityResult Success()
        {
            return new IdentityResult(true, new string[] { });
        }

        public static IdentityResult Failure(IEnumerable<string> errors)
        {
            return new IdentityResult(false, errors);
        }
    }
}