using System.IO;

namespace WebChat.Infrastructure.API
{
    public static class InfrastructureDefaults
    {
        public static string Database => "WebChatDatabase";
        public static string IdentityDatabase => "WebChatIdentityDatabase";
        public static string Environment => "ASPNETCORE_ENVIRONMENT";
        public static string JwtSectionName => "JsonWebToken";
        
        public static string StartDirectory
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