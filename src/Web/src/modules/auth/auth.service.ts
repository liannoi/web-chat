import {Injectable} from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';

import {Observable, throwError} from 'rxjs';
import {catchError} from 'rxjs/operators';
import {CookieService} from 'ngx-cookie-service';

import {ApiEndpoints} from '../api/api.constants';
import {LoginModel} from './common/models/login.model';
import {JwtTokenModel} from './common/models/jwt-token.model';
import {UserJwtTokenName} from '../../app/app.constants';
import {RegisterModel} from './common/models/register.model';

@Injectable()
export class AuthService {
  public constructor(private http: HttpClient, private cookieService: CookieService) {
  }

  public login(user: LoginModel): Observable<JwtTokenModel> {
    return this.http.post<JwtTokenModel>(ApiEndpoints.UsersLogin, user).pipe(catchError(this.handleError));
  }

  public signup(user: RegisterModel): Observable<JwtTokenModel> {
    return this.http.post<JwtTokenModel>(ApiEndpoints.UsersSignup, user).pipe(catchError(this.handleIdentityError));
  }

  public verify(token: JwtTokenModel = this.readToken()): Observable<LoginModel> {
    return this.http.post<LoginModel>(ApiEndpoints.UsersVerify, token, this.authorize(token)).pipe(catchError(this.handleError));
  }

  public checkToken(): boolean {
    return this.cookieService.check(UserJwtTokenName);
  }

  public readToken(): JwtTokenModel {
    return {value: this.cookieService.get(UserJwtTokenName)};
  }

  public writeToken(token: JwtTokenModel) {
    this.cookieService.set(UserJwtTokenName, token.value, {path: '/'});
  }

  public clearToken() {
    this.cookieService.delete(UserJwtTokenName);
  }

  // Helpers.

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
