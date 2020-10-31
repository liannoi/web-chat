import {Injectable} from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';

import {Observable, Subject, throwError} from 'rxjs';
import {catchError, takeUntil} from 'rxjs/operators';
import {CookieService} from 'ngx-cookie-service';

import {ApiEndpoints} from '../../core/api/api.constants';
import {UserModel} from './user.model';
import {JwtTokenModel} from './jwt-token.model';
import {ApplicationNamings} from '../../app.constants';

@Injectable()
export class AuthService implements OnDispose {
  public stop$: Subject<void> = new Subject<void>();

  public constructor(private http: HttpClient, private cookieService: CookieService) {
  }

  ///////////////////////////////////////////////////////////////////////////
  // Commands
  ///////////////////////////////////////////////////////////////////////////

  public login(user: UserModel): Observable<JwtTokenModel> {
    return this.http.post<JwtTokenModel>(ApiEndpoints.UsersLogin, user)
      .pipe(catchError(this.handleError));
  }

  public signup(request: SignupCommand, handler: OnSignup) {
    this.http.post<JwtTokenModel>(ApiEndpoints.UsersSignup, request.user)
      .pipe(catchError(this.handleIdentityError))
      .pipe(takeUntil(this.stop$))
      .subscribe(token => handler.onSignupSuccess(token), error => handler.onSignupFailed(error));
  }

  public verify(request: VerifyCommand, handler: OnVerified) {
    const token = request.token;

    return this.http.post<UserModel>(ApiEndpoints.UsersVerify, token, this.authorize(token))
      .pipe(catchError(this.handleError))
      .pipe(takeUntil(this.stop$))
      .subscribe(user => handler.onVerifiedSuccess(user), error => handler.onVerifiedFailed(error));
  }

  ///////////////////////////////////////////////////////////////////////////
  // Methods for working with JWT token
  ///////////////////////////////////////////////////////////////////////////

  public checkToken(): boolean {
    return this.cookieService.check(ApplicationNamings.UserJwtToken);
  }

  public readToken(): JwtTokenModel {
    return {value: this.cookieService.get(ApplicationNamings.UserJwtToken)};
  }

  public writeToken(token: JwtTokenModel) {
    this.cookieService.set(ApplicationNamings.UserJwtToken, token.value, {path: '/'});
  }

  public clearToken() {
    this.cookieService.delete(ApplicationNamings.UserJwtToken);
  }

  ///////////////////////////////////////////////////////////////////////////
  // Dispose
  ///////////////////////////////////////////////////////////////////////////

  public onDispose() {
    this.stop$.next();
    this.stop$.complete();
  }

  ///////////////////////////////////////////////////////////////////////////
  // Helpers
  ///////////////////////////////////////////////////////////////////////////

  private handleIdentityError(error): Observable<never> {
    return throwError(error.error.text);
  }

  private handleError(error): Observable<never> {
    let errorMessage: string;
    if (error.error instanceof ErrorEvent) {
      errorMessage = `Error: ${error.error.message}`;
    } else {
      errorMessage = `Error Code: ${error.status}\nMessage: ${error.message}`;
    }

    console.log(errorMessage);

    return throwError(errorMessage);
  }

  private authorize(token: JwtTokenModel): { headers: HttpHeaders } {
    return {headers: new HttpHeaders({Authorization: `Bearer ${token.value}`})};
  }
}

///////////////////////////////////////////////////////////////////////////
// Dispose
///////////////////////////////////////////////////////////////////////////

export interface OnDispose {
  onDispose(): void;
}

///////////////////////////////////////////////////////////////////////////
// Signup Command
///////////////////////////////////////////////////////////////////////////

export class SignupCommand {
  public constructor(public user: UserModel) {
  }
}

export interface OnSignup {
  onSignupSuccess(token: JwtTokenModel): void;

  onSignupFailed(error: any): void;
}

///////////////////////////////////////////////////////////////////////////
// Verify Command
///////////////////////////////////////////////////////////////////////////

export class VerifyCommand {
  public constructor(public token: JwtTokenModel) {
  }
}

export interface OnVerified {
  onVerifiedSuccess(token: UserModel): void;

  onVerifiedFailed(error: any): void;
}
