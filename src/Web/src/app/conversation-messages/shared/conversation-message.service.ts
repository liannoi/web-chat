import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';

import {AbstractApiService} from '../../core/abstract-api.service';
import {ConversationMessageModel} from './conversation-message.model';
import {ApiEndpoints} from '../../shared/api.constants';
import {catchError, takeUntil} from 'rxjs/operators';

@Injectable()
export class ConversationMessageService extends AbstractApiService<ConversationMessageModel> {
  constructor(http: HttpClient) {
    super(http);
  }

  public create(request: CreateCommand, handler: OnCreate) {
    this.http.post(ApiEndpoints.ConversationMessages, request.conversationMessage)
      .pipe(catchError(this.handleError))
      .pipe(takeUntil(this.stop$))
      .subscribe(() => handler.onCreateSuccess(), error => handler.onCreateFailed(error));
  }
}

///////////////////////////////////////////////////////////////////////////
// Create Command
///////////////////////////////////////////////////////////////////////////

export class CreateCommand {
  public constructor(public conversationMessage: ConversationMessageModel) {
  }
}

export interface OnCreate {
  onCreateSuccess(): void;

  onCreateFailed(error: any): void;
}
