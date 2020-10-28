import {Component, OnDestroy, OnInit} from '@angular/core';
import {Router} from '@angular/router';
import {FormControl, FormGroup} from '@angular/forms';

import {Subject} from 'rxjs';
import {takeUntil} from 'rxjs/operators';

import {AuthService} from '../auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit, OnDestroy {
  public formGroup: FormGroup;
  private $stop: Subject<void> = new Subject<void>();

  public constructor(private authService: AuthService, private router: Router) {
  }

  public ngOnInit() {
    this.formGroup = new FormGroup({
      'user[username]': new FormControl(),
      'user[password]': new FormControl()
    });
  }

  public ngOnDestroy() {
    this.$stop.next();
    this.$stop.complete();
  }

  public login(): void {
    let jwt: string;

    this.authService.login({userName: 'test', password: '123mcmc123!!PASS'})
      .pipe(takeUntil(this.$stop))
      .subscribe((result) => {
        jwt = result.value;
        console.log(jwt);
        this.router.navigate(['/']);
      }, error => {
        console.error(error);
        this.router.navigate(['/']);
      });
  }

  public register() {
    return undefined;
  }
}
