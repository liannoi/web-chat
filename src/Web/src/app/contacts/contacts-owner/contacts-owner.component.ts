import {Component, OnDestroy, OnInit} from '@angular/core';
import {Title} from '@angular/platform-browser';
import {Router} from '@angular/router';

import {AuthService, OnVerified, VerifyCommand} from '../../core/auth.service';
import {UserModel} from '../../auth/shared/user.model';
import {ApplicationNamings, ApplicationPaths} from '../../shared/app.constants';
import {ContactsOwnerService, DetailsQuery, OnDetails} from '../shared/contacts-owner.service';
import {ContactsListModel} from '../shared/contacts-list.model';

@Component({
  selector: 'app-contacts-owner',
  templateUrl: './contacts-owner.component.html',
  styleUrls: ['./contacts-owner.component.css']
})

/*export class ContactsOwnerComponent implements OnInit, OnDetails {
  public contacts: ContactsListModel;

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
    this.contacts = model;
  }
}*/

export class ContactsOwnerComponent implements OnInit, OnDestroy, OnVerified, OnDetails {
  public contacts: ContactsListModel;

  public constructor(private titleService: Title,
                     private router: Router,
                     private authService: AuthService,
                     private contactsOwnerService: ContactsOwnerService) {
    titleService.setTitle(`Contacts - ${ApplicationNamings.Application}`);
  }

  public ngOnInit(): void {
    this.authService.verify(new VerifyCommand(this.authService.readToken()), this);
  }

  public onVerifiedSuccess(user: UserModel): void {
    this.contactsOwnerService.getById(new DetailsQuery(user.userId), this);
  }

  public onVerifiedFailed(error: any): void {
    console.error(error);
    this.authService.clearToken();
    this.router.navigate([ApplicationPaths.Login]);
  }

  public onDetailsSuccess(model: ContactsListModel): void {
    this.contacts = model;
  }

  public onDetailsFailed(error: any): void {
  }

  public ngOnDestroy() {
    this.authService.onDispose();
  }
}
