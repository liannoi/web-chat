import {Injectable} from '@angular/core';
import {AbstractApiService} from '../../core/abstract-api.service';
import {ConversationModel} from './conversation.model';
import {HttpClient} from '@angular/common/http';
import {ApiEndpoints} from '../../shared/api.constants';
import {catchError, takeUntil} from 'rxjs/operators';

@Injectable()
export class ConversationService extends AbstractApiService<ConversationModel> {
  constructor(http: HttpClient) {
    super(http);
  }

  public create(request: CreateCommand, handler: OnCreate) {
    this.http.post(`${ApiEndpoints.Conversations}`, request.conversation)
      .pipe(catchError(this.handleError))
      .pipe(takeUntil(this.stop$))
      .subscribe(() => handler.onCreateSuccess(), error => handler.onCreateFailed(error));
  }
}

///////////////////////////////////////////////////////////////////////////
// Create Command
///////////////////////////////////////////////////////////////////////////

export class CreateCommand {
  public constructor(public conversation: ConversationModel) {
  }
}

export interface OnCreate {
  onCreateSuccess(): void;

  onCreateFailed(error: any): void;
}
