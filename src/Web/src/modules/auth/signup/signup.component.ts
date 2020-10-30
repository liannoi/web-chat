import {Component, OnDestroy, OnInit} from '@angular/core';
import {FormControl, FormGroup, Validators} from '@angular/forms';
import {Router} from '@angular/router';

import {Subject} from 'rxjs';
import {takeUntil} from 'rxjs/operators';

import {AuthService} from '../auth.service';
import {RegisterModel} from '../common/models/register.model';

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
  styleUrls: ['./signup.component.css']
})
export class SignupComponent implements OnInit, OnDestroy {
  public formGroup: FormGroup;
  public haveFirstAttempt = false;
  public identityError = '';
  private user: RegisterModel = {userName: '', password: ''};
  private stop$: Subject<void> = new Subject<void>();

  public constructor(private authService: AuthService, private router: Router) {
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

  public signup() {
    if (!this.formGroup.valid) {
      return;
    }

    this.user = this.formGroup.getRawValue() as RegisterModel;

    this.authService.signup(this.user)
      .pipe(takeUntil(this.stop$))
      .subscribe(token => {
        this.authService.writeToken(token);
        this.redirectToHome();
      }, error => {
        console.error(error);
        this.userName.setValue(this.user.userName);
        this.password.setValue('');
        this.haveFirstAttempt = true;
        this.identityError = error;
        this.formGroup.setErrors({identity: true});
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
    });
  }

  private redirectToHome() {
    this.router.navigate(['/']);
  }
}
