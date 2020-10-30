import {Component, OnDestroy, OnInit} from '@angular/core';
import {Router} from '@angular/router';
import {FormControl, FormGroup, Validators} from '@angular/forms';

import {Subject} from 'rxjs';
import {takeUntil} from 'rxjs/operators';
import {CookieService} from 'ngx-cookie-service';

import {AuthService} from '../auth.service';
import {UserModel} from '../common/models/user.model';
import {unauthorizedValidator} from '../common/validators/unauthorized.validator';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit, OnDestroy {
  public formGroup: FormGroup;
  public haveFirstAttempt = false;
  private user: UserModel;
  private $stop: Subject<void> = new Subject<void>();

  public constructor(private authService: AuthService, private router: Router, private cookieService: CookieService) {
    this.user = {userName: '', password: ''};
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
    this.$stop.next();
    this.$stop.complete();
  }

  public login() {
    if (!this.formGroup.valid) {
      return;
    }

    const user = this.formGroup.getRawValue() as UserModel;

    this.authService.login(user)
      .pipe(takeUntil(this.$stop))
      .subscribe(token => {
        this.cookieService.set('user_token', token.value, {path: '/', expires: new Date().getDate() + 7});
        this.redirectToHome();
      }, error => {
        console.error(error);
        this.userName.setValue(user.userName);
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
