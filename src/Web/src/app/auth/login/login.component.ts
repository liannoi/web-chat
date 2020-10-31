import {Component, OnDestroy, OnInit} from '@angular/core';
import {Router} from '@angular/router';
import {FormControl, FormGroup, Validators} from '@angular/forms';
import {Title} from '@angular/platform-browser';

import {UserModel} from '../shared/models/user.model';
import {unauthorizedValidator} from '../shared/validators/unauthorized.validator';
import {ApplicationNamings, ApplicationPaths} from '../../app.constants';
import {JwtTokenModel} from '../shared/models/jwt-token.model';
import {LoginCommand, OnLogin} from '../shared/commands/login-command.model';
import {AuthService} from '../../core/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit, OnDestroy, OnLogin {
  public formGroup: FormGroup;
  public haveFirstAttempt = false;
  public paths = ApplicationPaths;
  private user: UserModel = {userName: '', password: ''};

  public constructor(private authService: AuthService, private router: Router, private titleService: Title) {
    titleService.setTitle(`Sign in to ${ApplicationNamings.Application}`);
  }

  ///////////////////////////////////////////////////////////////////////////
  // Getters for the form
  ///////////////////////////////////////////////////////////////////////////

  get userName() {
    return this.formGroup.get('userName');
  }

  get password() {
    return this.formGroup.get('password');
  }

  ///////////////////////////////////////////////////////////////////////////
  // Event handlers
  ///////////////////////////////////////////////////////////////////////////

  public ngOnInit() {
    this.setupForm();
  }

  public onLoginSuccess(token: JwtTokenModel): void {
    this.authService.writeToken(token);
    this.router.navigate(['/']);
  }

  public onLoginFailed(error: any): void {
    console.error(error);
    this.userName.setValue(this.user.userName);
    this.password.setValue('');
    this.haveFirstAttempt = true;
  }

  public ngOnDestroy() {
    this.authService.onDispose();
  }

  ///////////////////////////////////////////////////////////////////////////
  // Basic methods
  ///////////////////////////////////////////////////////////////////////////

  public login() {
    if (!this.formGroup.valid) {
      return;
    }

    this.user = this.formGroup.getRawValue() as UserModel;
    this.authService.login(new LoginCommand(this.user), this);
  }

  ///////////////////////////////////////////////////////////////////////////
  // Helpers
  ///////////////////////////////////////////////////////////////////////////

  private setupForm() {
    this.formGroup = new FormGroup({
      userName: new FormControl(this.user.userName, [
        Validators.required,
        Validators.pattern('^([^\\s]*)$')
      ]),
      password: new FormControl(this.user.password, [
        Validators.required,
        Validators.pattern('^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$')
      ])
    }, {validators: unauthorizedValidator});
  }
}
