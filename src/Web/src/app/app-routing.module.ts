import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';

import {ApplicationPaths} from './app.constants';
import {HomeComponent} from './shared/home/home.component';
import {DocsApiComponent} from './shared/docs-api/docs-api.component';
import {StatusNotFoundComponent} from './shared/status-not-found/status-not-found.component';

const routes: Routes = [
  {path: ApplicationPaths.Home, component: HomeComponent, pathMatch: 'full'},
  {path: ApplicationPaths.DocsApi, component: DocsApiComponent},
  {path: ApplicationPaths.StatusNotFound, component: StatusNotFoundComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {
}
