import {Component, OnDestroy, OnInit} from '@angular/core';
import {Title} from '@angular/platform-browser';
import {Router} from '@angular/router';

import {AuthService, OnVerified, VerifyCommand} from '../../core/auth.service';
import {UserModel} from '../../auth/shared/user.model';
import {ApplicationNamings, ApplicationPaths} from '../../shared/app.constants';
import {ContactsOwnerService, ListQuery, OnList} from '../shared/contacts-owner.service';
import {ContactsListModel} from '../shared/contacts-list.model';

@Component({
  selector: 'app-contacts-owner',
  templateUrl: './contacts-owner.component.html',
  styleUrls: ['./contacts-owner.component.css']
})

export class ContactsOwnerComponent implements OnInit, OnDestroy, OnVerified, OnList {
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
    this.contactsOwnerService.getAll(new ListQuery(user.userId), this);
  }

  public onVerifiedFailed(error: any): void {
    console.error(error);
    this.authService.clearToken();
    this.router.navigate([ApplicationPaths.Login]);
  }

  public onListSuccess(model: ContactsListModel): void {
    this.contacts = model;
  }

  public onListFailed(error: any): void {
  }

  public ngOnDestroy() {
    this.authService.onDispose();
  }
}
