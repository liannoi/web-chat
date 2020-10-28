namespace WebChat.Application.API.Common.Identity
{
    public interface ICurrentUserService
    {
        string UserId { get; }
    }
}