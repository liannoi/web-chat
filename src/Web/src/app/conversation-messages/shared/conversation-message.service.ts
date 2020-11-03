import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';

import {catchError, takeUntil} from 'rxjs/operators';

import {AbstractApiService} from '../../core/abstract-api.service';
import {ConversationMessageModel} from './conversation-message.model';
import {ConversationMessageListModel} from './conversation-message-list.model';
import {ApiEndpoints} from '../../shared/api.constants';

@Injectable()
export class ConversationMessageService extends AbstractApiService<ConversationMessageModel> {
  constructor(http: HttpClient) {
    super(http);
  }

  public getAll(request: ListQuery, handler: OnList) {
    this.http.get<ConversationMessageListModel>(`${ApiEndpoints.CrimeaGetAll}/${request.conversationId}`)
      .pipe(catchError(this.handleError))
      .pipe(takeUntil(this.stop$))
      .subscribe(model => handler.onListSuccess(model), error => handler.onListFailed(error));
  }
}

///////////////////////////////////////////////////////////////////////////
// List Query
///////////////////////////////////////////////////////////////////////////

export class ListQuery {
  public constructor(public conversationId: number) {
  }
}

export interface OnList {
  onListSuccess(model: ConversationMessageListModel): void;

  onListFailed(error: any): void;
}
