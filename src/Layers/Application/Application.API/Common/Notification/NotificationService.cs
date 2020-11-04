using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;

namespace WebChat.Application.API.Common.Notification
{
    public class NotificationService : Hub<INotificationService>
    {
        public async Task SendNotification(string message)
        {
            await Clients.All.ReceiveNotification(message);
        }
    }
}