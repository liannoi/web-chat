using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Microsoft.AspNetCore.SignalR;
using WebChat.Application.API.Common.Notification;

namespace WebChat.Application.API.Storage.ConversationMessages.Core.Commands.Create
{
    public class MessageCreated : INotification
    {
        public int MessageId { get; set; }

        private class Handler : INotificationHandler<MessageCreated>
        {
            private readonly IHubContext<NotificationService, INotificationService> _notificationService;

            public Handler(IHubContext<NotificationService, INotificationService> notificationService)
            {
                _notificationService = notificationService;
            }

            public async Task Handle(MessageCreated notification, CancellationToken cancellationToken)
            {
                await _notificationService.Clients.All.ReceiveNotification(notification.MessageId.ToString());
            }
        }
    }
}