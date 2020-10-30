using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using WebChat.Application.API.Common.Identity;
using WebChat.Application.API.Common.Interfaces;
using WebChat.Infrastructure.API.Identity;
using WebChat.Infrastructure.API.Identity.Server;
using WebChat.Infrastructure.API.Persistence;

namespace WebChat.Infrastructure.API
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddInfrastructureServices(this IServiceCollection services,
            IConfiguration configuration)
        {
            // Persistence.
            services.AddDbContext<WebChatContext>(options =>
                options.UseSqlServer(configuration.GetConnectionString(InfrastructureDefaults.Database)));

            services.AddScoped<IWebChatContext>(provider => provider.GetService<WebChatContext>());

            // Identity.
            services.AddDbContext<WebChatIdentityContext>(options =>
                options.UseSqlServer(configuration.GetConnectionString(InfrastructureDefaults.IdentityDatabase)));

            services.AddIdentity<ApplicationUser, IdentityRole>().AddEntityFrameworkStores<WebChatIdentityContext>();

            services.AddAuthorization();
            services.AddScoped<IIdentityService, IdentityService>();

            var section = configuration.GetSection(InfrastructureDefaults.JwtSectionName);
            services.Configure<IdentitySettings>(section);
            var appSettings = section.Get<IdentitySettings>();

            services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
                .AddJwtBearer(options =>
                {
                    options.TokenValidationParameters = new TokenValidationParameters
                    {
                        ValidateIssuer = true,
                        ValidateAudience = true,
                        ValidateLifetime = true,
                        ValidateIssuerSigningKey = true,
                        ValidIssuer = appSettings.Issuer,
                        ValidAudience = appSettings.Issuer,
                        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(appSettings.Secret))
                    };
                });

            return services;
        }
    }
}