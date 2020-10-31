import {Component, OnDestroy, OnInit} from '@angular/core';
import {Router} from '@angular/router';
import {FormControl, FormGroup, Validators} from '@angular/forms';
import {Title} from '@angular/platform-browser';

import {Subject} from 'rxjs';
import {takeUntil} from 'rxjs/operators';

import {AuthService} from '../auth.service';
import {LoginModel} from '../common/models/login.model';
import {unauthorizedValidator} from '../common/validators/unauthorized.validator';
import {ApplicationName, ApplicationPaths} from '../../../app/app.constants';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit, OnDestroy {
  public formGroup: FormGroup;
  public haveFirstAttempt = false;
  public paths = ApplicationPaths;
  private user: LoginModel = {userName: '', password: ''};
  private stop$: Subject<void> = new Subject<void>();

  public constructor(private authService: AuthService, private router: Router, private titleService: Title) {
    titleService.setTitle(`Sign in to ${ApplicationName}`);
  }

  get userName() {
    return this.formGroup.get('userName');
  }

  get password() {
    return this.formGroup.get('password');
  }

  public ngOnInit() {
    this.setupForm();
  }

  public ngOnDestroy() {
    this.stop$.next();
    this.stop$.complete();
  }

  public login() {
    if (!this.formGroup.valid) {
      return;
    }

    this.user = this.formGroup.getRawValue() as LoginModel;

    this.authService.login(this.user)
      .pipe(takeUntil(this.stop$))
      .subscribe(token => {
        this.authService.writeToken(token);
        this.redirectToHome();
      }, error => {
        console.error(error);
        this.userName.setValue(this.user.userName);
        this.password.setValue('');
        this.haveFirstAttempt = true;
      });
  }

  // Helpers.

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

  private redirectToHome() {
    this.router.navigate(['/']);
  }
}
