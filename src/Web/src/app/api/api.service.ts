import {Observable} from 'rxjs';

export interface ApiService<TModel, TListModel> {
  getAll(): Observable<TListModel>;

  create(model: TModel): Observable<TModel>;

  getById(id: number): Observable<TModel>;

  update(id: number, model: TModel): Observable<TModel>;

  delete(id: number): Observable<TModel>;
}
