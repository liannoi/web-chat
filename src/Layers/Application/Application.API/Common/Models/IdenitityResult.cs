using System.Collections.Generic;
using System.Linq;

namespace WebChat.Application.API.Common.Models
{
    public class IdenitityResult
    {
        internal IdenitityResult(bool succeeded, IEnumerable<string> errors)
        {
            Succeeded = succeeded;
            Errors = errors.ToArray();
        }

        public bool Succeeded { get; set; }
        public string[] Errors { get; set; }

        public static IdenitityResult Success()
        {
            return new IdenitityResult(true, new string[] { });
        }

        public static IdenitityResult Failure(IEnumerable<string> errors)
        {
            return new IdenitityResult(false, errors);
        }
    }
}