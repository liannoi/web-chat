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

  public getAll() {
    return undefined;
  }

  public getById(request: DetailsQuery, handler: OnDetails) {
    this.http.get<ContactsListModel>(`${ApiEndpoints.ContactsOwner}/${request.ownerUserId}`)
      .pipe(catchError(this.handleError))
      .pipe(takeUntil(this.stop$))
      .subscribe(model => handler.onDetailsSuccess(model), error => handler.onDetailsFailed(error));
  }

  public update(id: number, model: ContactModel) {
    return undefined;
  }
}

///////////////////////////////////////////////////////////////////////////
// Details Query
///////////////////////////////////////////////////////////////////////////

export class DetailsQuery {
  public constructor(public ownerUserId: number) {
  }
}

export interface OnDetails {
  onDetailsSuccess(model: ContactsListModel): void;

  onDetailsFailed(error: any): void;
}
