import {Component, Input, OnInit} from '@angular/core';

import {BehaviorSubject} from 'rxjs';

import {ConversationMessageListModel} from '../shared/conversation-message-list.model';
import {ConversationModel} from '../../conversations/shared/conversation.model';
import {ConversationMessageModel} from '../shared/conversation-message.model';
import {AuthService, OnVerified, VerifyCommand} from '../../core/auth.service';
import {UserModel} from '../../auth/shared/user.model';
import {CrimeaService, ListQuery, OnList} from '../shared/crimea.service';

@Component({
  selector: 'app-conversation-message',
  templateUrl: './conversation-message.component.html',
  styleUrls: ['./conversation-message.component.css']
})
export class ConversationMessageComponent implements OnInit, OnList, OnVerified {
  public data: ConversationMessageModel[];
  public currentUser: UserModel;

  public constructor(private crimeaService: CrimeaService, private authService: AuthService) {
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

  public ngOnInit(): void {
    this.authService.verify(new VerifyCommand(this.authService.readToken()), this);

    this._conversation.subscribe(model => {
      if (!model) {
        return;
      }

      this.crimeaService.getAll(new ListQuery(model.conversationId), this);
    });
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
    this.messages = model.messages;
  }

  public isMyMessage(ownerUserId: number) {
    return ownerUserId === this.currentUser?.userId;
  }
}
