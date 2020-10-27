using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;

namespace WebChat.Infrastructure.API.Identity.Persistence.Context
{
    public abstract class DesignTimeDbContextFactoryBase<TContext> : IDesignTimeDbContextFactory<TContext>
        where TContext : DbContext
    {
        public TContext CreateDbContext(string[] args)
        {
            return Create(IdentityDefaults.ApplicationStartDirectory,
                Environment.GetEnvironmentVariable(IdentityDefaults.Environment));
        }

        protected abstract TContext CreateNewInstance(DbContextOptions<TContext> options);

        private TContext Create(string basePath, string environmentName)
        {
            return Create(new ConfigurationBuilder()
                .SetBasePath(basePath)
                .AddJsonFile("appsettings.json")
                .AddJsonFile("appsettings.Local.json", true)
                .AddJsonFile($"appsettings.{environmentName}.json", true)
                .AddEnvironmentVariables()
                .Build().GetConnectionString(IdentityDefaults.DatabaseNameInConnectionString));
        }

        private TContext Create(string connectionString)
        {
            if (string.IsNullOrEmpty(connectionString))
            {
                throw new ArgumentException(
                    $"Connection string '{IdentityDefaults.DatabaseNameInConnectionString}' is null or empty.",
                    nameof(connectionString));
            }

            Console.WriteLine(
                $"DesignTimeDbContextFactoryBase.Create(string): Connection string: '{connectionString}'.");
            
            var optionsBuilder = new DbContextOptionsBuilder<TContext>();
            optionsBuilder.UseSqlServer(connectionString);

            return CreateNewInstance(optionsBuilder.Options);
        }
    }
}