import {Component, OnDestroy, OnInit} from '@angular/core';
import {Router} from '@angular/router';
import {FormControl, FormGroup, Validators} from '@angular/forms';
import {Title} from '@angular/platform-browser';

import {faEye, faEyeSlash} from '@fortawesome/free-solid-svg-icons';

import {UserModel} from '../shared/user.model';
import {unauthorizedValidator} from '../shared/unauthorized.validator';
import {ApplicationNamings, ApplicationPaths} from '../../shared/app.constants';
import {JwtTokenModel} from '../shared/jwt-token.model';
import {AuthService, LoginCommand, OnLogin} from '../../core/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit, OnDestroy, OnLogin {

  public paths = ApplicationPaths;

  public formGroup: FormGroup;
  public haveFirstAttempt = false;

  public fieldTextType: boolean;
  public faEye = faEye;
  public faEyeSplash = faEyeSlash;

  private user: UserModel = new UserModel();

  public constructor(private authService: AuthService, private router: Router, private titleService: Title) {
    titleService.setTitle(`Sign in to ${ApplicationNamings.Application}`);
  }

  ///////////////////////////////////////////////////////////////////////////
  // Getters for the form
  ///////////////////////////////////////////////////////////////////////////

  get username() {
    return this.formGroup.get('username');
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
    this.router.navigate([this.paths.Home]);
  }

  public onLoginFailed(error: any): void {
    console.error(error);
    this.username.setValue(this.user.userName);
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

  public toggleFieldTextType() {
    this.fieldTextType = !this.fieldTextType;
  }

  ///////////////////////////////////////////////////////////////////////////
  // Helpers
  ///////////////////////////////////////////////////////////////////////////

  private setupForm() {
    this.formGroup = new FormGroup({
      username: new FormControl(this.user.userName, [
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
