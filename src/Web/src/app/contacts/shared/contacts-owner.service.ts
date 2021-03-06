import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';

import {catchError, takeUntil} from 'rxjs/operators';

import {AbstractApiService} from '../../core/abstract-api.service';
import {ContactModel} from './contact.model';
import {ApiEndpoints} from '../../shared/api.constants';
import {ContactsListModel} from './contacts-list.model';

@Injectable()
export class ContactsOwnerService extends AbstractApiService<ContactModel> {
  constructor(http: HttpClient) {
    super(http);
  }

  public create(model: ContactModel) {
    return undefined;
  }

  public delete(id: number) {
    return undefined;
  }

  public getById() {
    return undefined;
  }

  public getAll(request: ListQuery, handler: OnList) {
    this.http.get<ContactsListModel>(`${ApiEndpoints.ContactsOwner}/${request.ownerUserId}`)
      .pipe(catchError(this.handleError))
      .pipe(takeUntil(this.stop$))
      .subscribe(model => handler.onListSuccess(model), error => handler.onListFailed(error));
  }

  public update(id: number, model: ContactModel) {
    return undefined;
  }
}

///////////////////////////////////////////////////////////////////////////
// List Query
///////////////////////////////////////////////////////////////////////////

export class ListQuery {
  public constructor(public ownerUserId: number) {
  }
}

export interface OnList {
  onListSuccess(model: ContactsListModel): void;

  onListFailed(error: any): void;
}
