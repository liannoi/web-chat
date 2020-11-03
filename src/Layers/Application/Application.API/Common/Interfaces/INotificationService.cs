using System.Threading.Tasks;

namespace WebChat.Application.API.Common.Interfaces
{
    public interface INotificationService
    {
        public Task ReceiveNotification(string message);
    }
}