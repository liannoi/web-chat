using System.IO;

namespace WebChat.Infrastructure.API.Identity
{
    public static class IdentityDefaults
    {
        public static string DatabaseNameInConnectionString => "WebChatDatabase";
        public static string IdentityDatabaseNameInConnectionString => "WebChatIdentityDatabase";
        public static string Environment => "ASPNETCORE_ENVIRONMENT";

        public static string ApplicationStartDirectory
        {
            get
            {
                var separator = Path.DirectorySeparatorChar;
                var up = $"..{separator}";

                return
                    $"{Directory.GetCurrentDirectory()}{separator}{up}{up}Presentation{separator}Presentation.API{separator}";
            }
        }
    }
}