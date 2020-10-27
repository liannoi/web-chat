using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using WebChat.Application.API.Common.Interfaces;
using WebChat.Infrastructure.API.Identity;
using WebChat.Infrastructure.API.Identity.Persistence;
using WebChat.Infrastructure.API.Identity.Persistence.Context;
using WebChat.Infrastructure.API.Persistence;

namespace WebChat.Infrastructure.API
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddInfrastructureServices(this IServiceCollection services,
            IConfiguration configuration)
        {
            // Main Database.
            services.AddDbContext<WebChatContext>(options =>
                options.UseSqlServer(configuration.GetConnectionString("WebChatDatabase")));

            services.AddScoped<IWebChatContext>(provider => provider.GetService<WebChatContext>());

            // ASP.NET Core Identity Database.
            services.AddDbContext<WebChatIdentityContext>(options =>
                options.UseSqlServer(configuration.GetConnectionString("WebChatIdentityDatabase")));

            services.AddDefaultIdentity<ApplicationUser>().AddEntityFrameworkStores<WebChatIdentityContext>();
            services.AddIdentityServer().AddApiAuthorization<ApplicationUser, WebChatIdentityContext>();
            services.AddScoped<IIdentityService, IdentityService>();
            services.AddAuthentication().AddIdentityServerJwt();

            return services;
        }
    }
}