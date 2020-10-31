import {Component, OnDestroy, OnInit} from '@angular/core';
import {FormControl, FormGroup, Validators} from '@angular/forms';
import {Router} from '@angular/router';
import {Title} from '@angular/platform-browser';

import {AuthService, OnSignup, SignupCommand} from '../shared/auth.service';
import {UserModel} from '../shared/user.model';
import {ApplicationNamings, ApplicationPaths} from '../../app.constants';
import {JwtTokenModel} from '../shared/jwt-token.model';

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.css']
})
export class SignupComponent implements OnInit, OnDestroy, OnSignup {
  public formGroup: FormGroup;
  public haveFirstAttempt = false;
  public identityError = '';
  private user: UserModel = {userName: '', password: ''};

  public constructor(private authService: AuthService, private router: Router, private titleService: Title) {
    titleService.setTitle(`Join ${ApplicationNamings.Application}`);
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

  public onSignupSuccess(token: JwtTokenModel): void {
    this.authService.writeToken(token);
    this.router.navigate([ApplicationPaths.Home]);
  }

  public onSignupFailed(error: any): void {
    console.error(error);
    this.userName.setValue(this.user.userName);
    this.password.setValue('');
    this.haveFirstAttempt = true;
    this.identityError = error;
    this.formGroup.setErrors({identity: true});
  }

  public ngOnDestroy() {
    this.authService.onDispose();
  }

  ///////////////////////////////////////////////////////////////////////////
  // Basic methods
  ///////////////////////////////////////////////////////////////////////////

  public signup() {
    if (!this.formGroup.valid) {
      return;
    }

    this.user = this.formGroup.getRawValue() as UserModel;
    this.authService.signup(new SignupCommand(this.user), this);
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
    });
  }
}
