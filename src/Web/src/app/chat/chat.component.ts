import {Component, OnDestroy, OnInit} from '@angular/core';
import {Title} from '@angular/platform-browser';
import {Router} from '@angular/router';

import {Subject} from 'rxjs';
import {takeUntil} from 'rxjs/operators';

import {ApplicationName} from '../app.constants';
import {AuthService} from '../../modules/auth/auth.service';

@Component({
  selector: 'app-chat',
  templateUrl: './chat.component.html',
  styleUrls: ['./chat.component.css']
})
export class ChatComponent implements OnInit, OnDestroy {
  private stop$: Subject<void> = new Subject<void>();

  public constructor(private titleService: Title, private router: Router, private authService: AuthService) {
    titleService.setTitle(ApplicationName);
  }

  public ngOnInit() {
    if (!this.authService.checkToken()) {
      this.redirectToLogin();
      return;
    }

    this.authService.verify(this.authService.readToken())
      .pipe(takeUntil(this.stop$))
      .subscribe(user => console.log(user), error => {
        console.error(error);
        this.redirectToLogin();
      });
  }

  public ngOnDestroy() {
    this.stop$.next();
    this.stop$.complete();
  }

  // Helpers.

  private redirectToLogin() {
    this.router.navigate(['auth/login']);
  }
}
