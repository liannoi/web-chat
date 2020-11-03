using System.Threading.Tasks;
using Microsoft.AspNetCore.SignalR;
using WebChat.Application.API.Common.Interfaces;

namespace WebChat.Application.API
{
    public class NotificationService : Hub<INotificationService>
    {
        public async Task SendNotification(string message)
        {
            await Clients.All.ReceiveNotification(message);
        }
    }
}