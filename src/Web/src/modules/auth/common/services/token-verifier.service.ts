import {Injectable} from '@angular/core';
import {Router} from '@angular/router';

import {takeUntil} from 'rxjs/operators';
import {Subject} from 'rxjs';

import {AuthService} from '../../auth.service';
import {OnTokenVerification} from '../models/token-verification.model';
import {ApplicationPaths} from '../../../../app/app.constants';

@Injectable()
export class TokenVerifierService {
  public stop$: Subject<void> = new Subject<void>();

  constructor(private authService: AuthService, private router: Router) {
  }

  public verify(handler: OnTokenVerification) {
    if (!this.authService.checkToken()) {
      // @ts-ignore
      handler.OnTokenVerificationFailed();
      return;
    }

    this.authService.verify()
      .pipe(takeUntil(this.stop$))
      .subscribe(
        user => handler.OnTokenVerificationSuccess(user),
        error => handler.OnTokenVerificationFailed(error)
      );
  }

  public redirectToLogin() {
    this.router.navigate([ApplicationPaths.Login]);
  }
}
