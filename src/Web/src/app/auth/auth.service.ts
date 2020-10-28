import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';

import {Observable, throwError} from 'rxjs';
import {catchError} from 'rxjs/operators';

import {ApiEndpoints} from '../api/api.constants';
import {UserModel} from './user.model';
import {JwtTokenModel} from './jwt-token.model';

@Injectable()
export class AuthService {
  public constructor(private http: HttpClient) {
  }

  public login(user: UserModel): Observable<JwtTokenModel> {
    return this.http.post<JwtTokenModel>(ApiEndpoints.UsersLogin, user).pipe(catchError(this.handleError));
  }

  public register() {
    return undefined;
  }

  private handleError(error) {
    const errorMessage = error.error instanceof ErrorEvent
      ? `Error: ${error.error.message}`
      : `Error Code: ${error.status}\nMessage: ${error.message}`;

    console.log(errorMessage);

    return throwError(errorMessage);
  }
}
