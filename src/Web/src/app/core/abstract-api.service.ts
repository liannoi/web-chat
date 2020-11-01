import {HttpClient} from '@angular/common/http';

import {Observable, Subject, throwError} from 'rxjs';

import {OnDispose} from './dispose.model';

export abstract class AbstractApiService<TModel> implements OnDispose {
  protected stop$: Subject<void> = new Subject<void>();

  protected constructor(protected http: HttpClient) {
  }

  public onDispose() {
    this.stop$.next();
    this.stop$.complete();
  }

  protected handleError(error): Observable<never> {
    let errorMessage: string;
    if (error.error instanceof ErrorEvent) {
      errorMessage = `Error: ${error.error.message}`;
    } else {
      errorMessage = `Error Code: ${error.status}\nMessage: ${error.message}`;
    }

    console.log(errorMessage);

    return throwError(errorMessage);
  }
}
