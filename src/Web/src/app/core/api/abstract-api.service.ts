import {Injectable} from '@angular/core';
import {HttpClient} from '@angular/common/http';

import {Observable} from 'rxjs';

import {ApiService} from './api.service';

@Injectable()
export abstract class AbstractApiService<TModel, TListModel> implements ApiService<TModel, TListModel> {
  protected endpoint: string;

  protected constructor(protected http: HttpClient) {
  }

  create(model: TModel): Observable<TModel> {
    return undefined;
  }

  delete(id: number): Observable<TModel> {
    return undefined;
  }

  getAll(): Observable<TListModel> {
    return undefined;
  }

  getById(id: number): Observable<TModel> {
    return undefined;
  }

  update(id: number, model: TModel): Observable<TModel> {
    return undefined;
  }
}
