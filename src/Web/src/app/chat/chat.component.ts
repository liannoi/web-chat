import {Component, OnDestroy, OnInit} from '@angular/core';
import {Title} from '@angular/platform-browser';
import {Router} from '@angular/router';

import {ApplicationNamings, ApplicationPaths} from '../shared/app.constants';
import {AuthService, OnVerified, VerifyCommand} from '../core/auth.service';
import {UserModel} from '../auth/shared/user.model';

@Component({
  selector: 'app-chat',
  templateUrl: './chat.component.html',
  styleUrls: ['./chat.component.css']
})
export class ChatComponent implements OnInit, OnDestroy, OnVerified {
  public user: UserModel;

  public constructor(private titleService: Title, private router: Router, private authService: AuthService) {
    titleService.setTitle(`${ApplicationNamings.Application} App`);
  }

  public ngOnInit() {
    this.authService.verify(new VerifyCommand(this.authService.readToken()), this);
  }

  public onVerifiedSuccess(user: UserModel): void {
    this.user = user;
    console.log(user);
  }

  public onVerifiedFailed(error: any): void {
    console.error(error);
    this.authService.clearToken();
    this.router.navigate([ApplicationPaths.Login]);
  }

  public ngOnDestroy() {
    this.authService.onDispose();
  }
}
