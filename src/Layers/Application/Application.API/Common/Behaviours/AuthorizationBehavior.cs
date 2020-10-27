using System;
using System.Linq;
using System.Reflection;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using WebChat.Application.API.Common.Exceptions;
using WebChat.Application.API.Common.Interfaces;
using WebChat.Application.API.Common.Security;

namespace WebChat.Application.API.Common.Behaviours
{
    public class AuthorizationBehavior<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse>
    {
        private readonly ICurrentUserService _currentUserService;
        private readonly IIdentityService _identityService;

        public AuthorizationBehavior(ICurrentUserService currentUserService, IIdentityService identityService)
        {
            _currentUserService = currentUserService;
            _identityService = identityService;
        }

        public async Task<TResponse> Handle(TRequest request, CancellationToken cancellationToken,
            RequestHandlerDelegate<TResponse> next)
        {
            var authorizeAttributes = request.GetType().GetCustomAttributes<AuthorizeAttribute>();

            if (!authorizeAttributes.Any()) return await next();

            // Must be authenticated user
            if (_currentUserService.UserId == null) throw new UnauthorizedAccessException();

            var authorizeAttributesWithRoles = authorizeAttributes.Where(a => !string.IsNullOrWhiteSpace(a.Roles));

            if (!authorizeAttributesWithRoles.Any()) return await next();
            {
                foreach (var roles in authorizeAttributesWithRoles.Select(a => a.Roles.Split(',')))
                {
                    var authorized = false;
                    foreach (var role in roles)
                    {
                        var isInRole = await _identityService.UserIsInRole(_currentUserService.UserId, role.Trim());
                        if (!isInRole) continue;
                        authorized = true;
                        break;
                    }

                    // Must be a member of at least one role in roles
                    if (!authorized) throw new ForbiddenAccessException();
                }
            }

            // User is authorized / authorization not required
            return await next();
        }
    }
}