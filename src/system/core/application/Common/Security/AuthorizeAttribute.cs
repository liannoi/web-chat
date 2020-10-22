using System;

namespace WebChat.Application.Common.Security
{
    [AttributeUsage(AttributeTargets.Class, AllowMultiple = true)]
    public class AuthorizeAttribute : Attribute
    {
        /// <summary>
        ///     Gets or sets a comma delimited list of roles that are allowed to access the resource.
        /// </summary>
        public string Roles { get; set; }
    }
}