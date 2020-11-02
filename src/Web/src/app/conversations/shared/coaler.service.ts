import {Injectable} from '@angular/core';
import {AbstractApiService} from '../../core/abstract-api.service';
import {ConversationModel} from './conversation.model';
import {HttpClient} from '@angular/common/http';
import {ConversationsListModel} from './conversations-list.model';
import {ApiEndpoints} from '../../shared/api.constants';
import {catchError, takeUntil} from 'rxjs/operators';

@Injectable()
export class CoalerService extends AbstractApiService<ConversationModel> {
  constructor(http: HttpClient) {
    super(http);
  }

  public getAll(request: ListQuery, handler: OnList) {
    this.http.get<ConversationsListModel>(`${ApiEndpoints.Coaler}/${request.userId}`)
      .pipe(catchError(this.handleError))
      .pipe(takeUntil(this.stop$))
      .subscribe(model => handler.onListSuccess(model), error => handler.onListFailed(error));
  }
}

///////////////////////////////////////////////////////////////////////////
// List Query
///////////////////////////////////////////////////////////////////////////

export class ListQuery {
  public constructor(public userId: number) {
  }
}

export interface OnList {
  onListSuccess(model: ConversationsListModel): void;

  onListFailed(error: any): void;
}
