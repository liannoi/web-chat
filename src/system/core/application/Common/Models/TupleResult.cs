using System.Collections.Generic;
using System.Linq;

namespace WebChat.Application.Common.Models
{
    public class TupleResult
    {
        internal TupleResult(bool succeeded, IEnumerable<string> errors)
        {
            Succeeded = succeeded;
            Errors = errors.ToArray();
        }

        public bool Succeeded { get; set; }
        public string[] Errors { get; set; }

        public static TupleResult Success()
        {
            return new TupleResult(true, new string[] { });
        }

        public static TupleResult Failure(IEnumerable<string> errors)
        {
            return new TupleResult(false, errors);
        }
    }
}