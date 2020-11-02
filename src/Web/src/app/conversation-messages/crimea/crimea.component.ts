import {Component, Input, OnInit} from '@angular/core';

import {BehaviorSubject} from 'rxjs';

import {ConversationMessageModel} from '../shared/conversation-message.model';
import {ConversationModel} from '../../conversations/shared/conversation.model';
import {ConversationMessageService, DetailsQuery, OnDetails} from '../shared/conversation-message.service';

@Component({
  selector: 'app-crimea',
  templateUrl: './crimea.component.html',
  styleUrls: ['./crimea.component.css']
})
export class CrimeaComponent implements OnInit, OnDetails {
  public message: ConversationMessageModel;

  public constructor(private conversationMessageService: ConversationMessageService) {
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
    this._conversation.subscribe(model => {
      if (!model) {
        return;
      }

      this.conversationMessageService.getById(new DetailsQuery(model.conversationId), this);
    });
  }

  public onDetailsFailed(error: any): void {
    console.error(error);
  }

  public onDetailsSuccess(model: ConversationMessageModel): void {
    this.message = model;
  }
}
