import {Injectable} from '@angular/core';

import {HubConnection, HubConnectionBuilder} from '@aspnet/signalr';

import {Notifiable} from './notificable';
import {ApiEndpoints} from '../shared/api.constants';

@Injectable()
// @ts-ignore
export class NotificationService implements Notifiable {
  // tslint:disable-next-line:variable-name
  private readonly _connection: HubConnection;

  constructor() {
    this._connection = new HubConnectionBuilder().withUrl(ApiEndpoints.Notifications).build();
  }

  public get connection(): HubConnection {
    return this._connection;
  }

  public send(message: string): void {
    this.connection.invoke('SendNotification', message);
  }

  public async run(): Promise<void> {
    return await this._connection.start()
      .then(() => console.log('Hub connection started'))
      .catch(err => {
        console.log(err);
        console.log('Error while establishing connection');
      });
  }
}
