import {Injectable} from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';

import {Observable, throwError} from 'rxjs';
import {catchError} from 'rxjs/operators';
import {CookieService} from 'ngx-cookie-service';

import {ApiEndpoints} from '../api/api.constants';
import {LoginModel} from './common/models/login.model';
import {JwtTokenModel} from './common/models/jwt-token.model';
import {UserJwtTokenName} from '../../app/app.constants';

@Injectable()
export class AuthService {
  public constructor(private http: HttpClient, private cookieService: CookieService) {
  }

  public login(user: LoginModel): Observable<JwtTokenModel> {
    return this.http.post<JwtTokenModel>(ApiEndpoints.UsersLogin, user).pipe(catchError(this.handleError));
  }

  public signup() {
    return undefined;
  }

  public verify(token: JwtTokenModel): Observable<LoginModel> {
    return this.http.post<LoginModel>(ApiEndpoints.UsersVerify, token, this.authorize(token)).pipe(catchError(this.handleError));
  }

  public checkToken(): boolean {
    return this.cookieService.check(UserJwtTokenName);
  }

  public readToken(): JwtTokenModel {
    return {value: this.cookieService.get(UserJwtTokenName)};
  }

  public writeToken(token: JwtTokenModel) {
    this.cookieService.set(UserJwtTokenName, token.value, {path: '/', expires: new Date().getDate() + 7});
  }

  // Helpers.

  private handleError(error): Observable<never> {
    const errorMessage = error.error instanceof ErrorEvent
      ? `Error: ${error.error.message}`
      : `Error Code: ${error.status}\nMessage: ${error.message}`;

    console.log(errorMessage);

    return throwError(errorMessage);
  }

  private authorize(token: JwtTokenModel): { headers: HttpHeaders } {
    return {headers: new HttpHeaders({Authorization: `Bearer ${token.value}`})};
  }
}
