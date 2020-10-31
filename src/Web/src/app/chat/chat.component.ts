import {Component, OnDestroy, OnInit} from '@angular/core';
import {Title} from '@angular/platform-browser';
import {Router} from '@angular/router';

import {Subject} from 'rxjs';
import {takeUntil} from 'rxjs/operators';

import {ApplicationNamings, ApplicationPaths} from '../app.constants';
import {AuthService} from '../auth/shared/auth.service';

@Component({
  selector: 'app-chat',
  templateUrl: './chat.component.html',
  styleUrls: ['./chat.component.css']
})
export class ChatComponent implements OnInit, OnDestroy {
  private stop$: Subject<void> = new Subject<void>();

  public constructor(private titleService: Title, private router: Router, private authService: AuthService) {
    titleService.setTitle(`${ApplicationNamings.Application} App`);
  }

  public ngOnInit() {
    this.verifyToken();
  }

  public ngOnDestroy() {
    this.stop$.next();
    this.stop$.complete();
  }

  // Helpers.

  private redirectToLogin() {
    this.router.navigate([ApplicationPaths.Login]);
  }

  private verifyToken() {
    /*if (!this.authService.checkToken()) {
      this.redirectToLogin();
      return;
    }

    this.authService.verify()
      .pipe(takeUntil(this.stop$))
      .subscribe(user => console.log(user), error => {
        this.authService.clearToken();
        console.error(error);
        this.redirectToLogin();
      });*/
  }
}
