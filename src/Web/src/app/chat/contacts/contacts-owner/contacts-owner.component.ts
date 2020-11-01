import {Component, Input, OnInit} from '@angular/core';

import {ContactsOwnerService, DetailsQuery, OnDetails} from '../shared/contacts-owner.service';
import {ContactsListModel} from '../shared/contacts-list.model';
import {UserModel} from '../../../auth/shared/user.model';
import {BehaviorSubject} from 'rxjs';

@Component({
  selector: 'app-contacts-owner',
  templateUrl: './contacts-owner.component.html',
  styleUrls: ['./contacts-owner.component.css']
})
export class ContactsOwnerComponent implements OnInit, OnDetails {
  public constructor(private contactsOwnerService: ContactsOwnerService) {
  }

  // tslint:disable-next-line:variable-name
  private _user = new BehaviorSubject<UserModel>(new UserModel());

  get user() {
    return this._user.getValue();
  }

  @Input()
  set user(value) {
    this._user.next(value);
  }

  public ngOnInit(): void {
    this._user.subscribe(x => {
      if (!x) {
        return;
      }

      this.contactsOwnerService.getById(new DetailsQuery(x.userId), this);
    });
  }

  public onDetailsFailed(error: any): void {
    console.error(error);
  }

  public onDetailsSuccess(model: ContactsListModel): void {
    console.log(model);
  }
}
