import {Component, Input, OnInit} from '@angular/core';

import {BehaviorSubject} from 'rxjs';

import {ConversationMessageListModel} from '../shared/conversation-message-list.model';
import {ConversationModel} from '../../conversations/shared/conversation.model';
import {ConversationMessageModel} from '../shared/conversation-message.model';
import {AuthService, OnVerified, VerifyCommand} from '../../core/auth.service';
import {UserModel} from '../../auth/shared/user.model';
import {CrimeaService, ListQuery, OnList} from '../shared/crimea.service';
import {NotificationService} from '../../core/notification.service';

@Component({
  selector: 'app-conversation-message',
  templateUrl: './conversation-message.component.html',
  styleUrls: ['./conversation-message.component.css']
})
export class ConversationMessageComponent implements OnInit, OnList, OnVerified {
  public data: ConversationMessageModel[];
  public currentUser: UserModel;
  public currentConversation: ConversationModel;

  public constructor(private crimeaService: CrimeaService,
                     private authService: AuthService,
                     private notificationService: NotificationService) {
  }

  // tslint:disable-next-line:variable-name
  private _messages = new BehaviorSubject<ConversationMessageModel[]>([]);

  public get messages(): ConversationMessageModel[] {
    return this._messages.getValue();
  }

  @Input()
  public set messages(value) {
    this._messages.next(value);
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
      this.crimeaService.getAll(new ListQuery(this.currentConversation.conversationId), this);
      isRefreshed = true;
    });

    await this.notificationService.run();

    if (!isRefreshed) {
      this.refresh();
    }
  }

  public onVerifiedSuccess(user: UserModel): void {
    this.currentUser = user;
  }

  public onVerifiedFailed(error: any): void {
    console.error(error);
  }

  public onListFailed(error: any): void {
    console.error(error);
  }

  public onListSuccess(model: ConversationMessageListModel): void {
    console.log(model);
    this._messages.next(model.messages);
  }

  public isMyMessage(ownerUserId: number) {
    return ownerUserId === this.currentUser?.userId;
  }

  public conversationUser(): string {
    return this.conversation.rightUser?.userId === this.currentUser?.userId
      ? this.conversation.leftUser?.userName
      : this.conversation.rightUser?.userName;
  }

  ///////////////////////////////////////////////////////////////////////////
  // Helpers
  ///////////////////////////////////////////////////////////////////////////

  private refresh() {
    this.authService.verify(new VerifyCommand(this.authService.readToken()), this);
    this._conversation.subscribe(model => {
      if (!model) {
        return;
      }

      this.currentConversation = model;
      this.crimeaService.getAll(new ListQuery(model.conversationId), this);
    });
  }
}
