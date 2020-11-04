using System.Threading.Tasks;

namespace WebChat.Application.API.Common.Notification
{
    public interface INotificationService
    {
        public Task ReceiveNotification(string message);
    }
}