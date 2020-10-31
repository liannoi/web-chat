import {Component, OnDestroy, OnInit} from '@angular/core';
import {Title} from '@angular/platform-browser';
import {Router} from '@angular/router';

import {AuthService} from '../../core/auth.service';
import {UserModel} from '../shared/models/user.model';
import {ApplicationNamings, ApplicationPaths} from '../../app.constants';
import {OnVerified, VerifyCommand} from '../shared/commands/verify-command.model';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit, OnDestroy, OnVerified {
  public constructor(private titleService: Title, private router: Router, private authService: AuthService) {
    titleService.setTitle(`Your profile - ${ApplicationNamings.Application}`);
  }

  public ngOnInit() {
    this.authService.verify(new VerifyCommand(this.authService.readToken()), this);
  }

  public onVerifiedSuccess(token: UserModel): void {
    console.log(token);
  }

  public onVerifiedFailed(error: any): void {
    console.error(error);
    this.authService.clearToken();
    this.router.navigate([ApplicationPaths.Home]);
  }

  public ngOnDestroy() {
    this.authService.onDispose();
  }
}