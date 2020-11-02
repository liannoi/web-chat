import {Component, Input, OnInit} from '@angular/core';

import {BehaviorSubject} from 'rxjs';

import {ConversationsListModel} from '../shared/conversations-list.model';
import {CoalerService, ListQuery, OnList} from '../shared/coaler.service';
import {UserModel} from '../../auth/shared/user.model';

@Component({
  selector: 'app-coaler',
  templateUrl: './coaler.component.html',
  styleUrls: ['./coaler.component.css']
})
export class CoalerComponent implements OnInit, OnList {
  public conversations: ConversationsListModel;

  public constructor(private coalerService: CoalerService) {
  }

  // tslint:disable-next-line:variable-name
  private _user = new BehaviorSubject<UserModel>(new UserModel());

  public get user(): UserModel {
    return this._user.getValue();
  }

  @Input()
  public set user(value) {
    this._user.next(value);
  }

  public ngOnInit(): void {
    this._user.subscribe(model => {
      if (!model) {
        return;
      }

      this.coalerService.getAll(new ListQuery(model.userId), this);
    });
  }

  public onListFailed(error: any): void {
    console.error(error);
  }

  public onListSuccess(model: ConversationsListModel): void {
    console.log(model);
    this.conversations = model;
  }
}
