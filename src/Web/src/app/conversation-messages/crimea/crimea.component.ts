import {Component, Input, OnInit} from '@angular/core';

import {BehaviorSubject} from 'rxjs';

import {ConversationMessageModel} from '../shared/conversation-message.model';
import {ConversationModel} from '../../conversations/shared/conversation.model';
import {CrimeaService, DetailsQuery, OnDetails} from '../shared/crimea.service';
import {NotificationService} from '../../core/notification.service';

@Component({
  selector: 'app-crimea',
  templateUrl: './crimea.component.html',
  styleUrls: ['./crimea.component.css']
})
export class CrimeaComponent implements OnInit, OnDetails {
  public message: ConversationMessageModel;
  private currentConversation: ConversationModel;

  public constructor(private conversationMessageService: CrimeaService, private notificationService: NotificationService) {
  }

  // tslint:disable-next-line:variable-name
  private _conversation = new BehaviorSubject<ConversationModel>(new ConversationModel());

  public get conversation(): ConversationModel {
    return this._conversation.getValue();
  }

  @Input()
  public set conversation(value) {
    this._conversation.next(value);
  }

  public async ngOnInit() {
    let isRefreshed = false;
    this.notificationService.connection.on('ReceiveNotification', () => {
      this.conversationMessageService.getById(new DetailsQuery(this.currentConversation?.conversationId), this);
      isRefreshed = true;
    });

    if (!isRefreshed) {
      this.refresh();
    }
  }

  public onDetailsFailed(error: any): void {
    console.error(error);
  }

  public onDetailsSuccess(model: ConversationMessageModel): void {
    this.message = model;
  }

  ///////////////////////////////////////////////////////////////////////////
  // Helpers
  ///////////////////////////////////////////////////////////////////////////

  private refresh() {
    this._conversation.subscribe(model => {
      if (!model) {
        return;
      }

      this.currentConversation = model;
      this.conversationMessageService.getById(new DetailsQuery(model.conversationId), this);
    });
  }
}
