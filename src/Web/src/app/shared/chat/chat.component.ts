import {Component, OnDestroy, OnInit} from '@angular/core';
import {Title} from '@angular/platform-browser';
import {Router} from '@angular/router';

import {ApplicationNamings, ApplicationPaths} from '../app.constants';
import {AuthService, OnVerified, VerifyCommand} from '../../core/auth.service';
import {UserModel} from '../../auth/shared/user.model';
import {ConversationModel} from '../../conversations/shared/conversation.model';
import {FormControl, FormGroup, Validators} from '@angular/forms';
import {ConversationMessageModel} from '../../conversation-messages/shared/conversation-message.model';
import {ConversationMessageService, CreateCommand, OnCreate} from '../../conversation-messages/shared/conversation-message.service';

@Component({
  selector: 'app-chat',
  templateUrl: './chat.component.html',
  styleUrls: ['./chat.component.css']
})
export class ChatComponent implements OnInit, OnDestroy, OnVerified, OnCreate {
  public user: UserModel;
  public currentConversation: ConversationModel;
  public sendMessageForm: FormGroup;
  public conversationMessage: ConversationMessageModel = new ConversationMessageModel();

  public constructor(private titleService: Title,
                     private router: Router,
                     private authService: AuthService,
                     private conversationMessageService: ConversationMessageService) {
    titleService.setTitle(`${ApplicationNamings.Application} App`);
  }

  get message() {
    return this.sendMessageForm.get('message');
  }

  public ngOnInit() {
    this.authService.verify(new VerifyCommand(this.authService.readToken()), this);
    this.setupForm();
  }

  public onVerifiedSuccess(user: UserModel): void {
    this.user = user;
    console.log(user);
  }

  public onVerifiedFailed(error: any): void {
    console.error(error);
    this.authService.clearToken();
    this.router.navigate([ApplicationPaths.Login]);
  }

  public ngOnDestroy() {
    this.authService.onDispose();
  }

  public updateCurrentConversation(conversation: ConversationModel) {
    this.currentConversation = conversation;
  }

  public onSendMessage() {
    if (!this.sendMessageForm.valid) {
      return;
    }

    this.conversationMessage = this.sendMessageForm.getRawValue() as ConversationMessageModel;
    this.conversationMessage.conversation = this.currentConversation;
    this.conversationMessage.ownerUserId = this.user.userId;
    this.conversationMessageService.create(new CreateCommand(this.conversationMessage), this);
  }

  public onCreateFailed(error: any): void {
    console.error(error);
  }

  public onCreateSuccess(): void {
    this.sendMessageForm.reset();
  }

  ///////////////////////////////////////////////////////////////////////////
  // Helpers
  ///////////////////////////////////////////////////////////////////////////

  private setupForm() {
    this.sendMessageForm = new FormGroup({
      message: new FormControl(this.conversationMessage.message, [Validators.required])
    });
  }
}
