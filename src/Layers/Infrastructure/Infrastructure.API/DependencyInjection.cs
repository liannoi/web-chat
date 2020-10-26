using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using WebChat.Application.API.Common.Interfaces;
using WebChat.Infrastructure.API.Persistence;

namespace WebChat.Infrastructure.API
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddInfrastructureServices(this IServiceCollection services,
            IConfiguration configuration)
        {
            services.AddDbContext<WebChatContext>(options =>
                options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

            services.AddScoped<IWebChatContext>(provider => provider.GetService<WebChatContext>());

            return services;
        }
    }
}