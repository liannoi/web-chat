import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';

import {ApplicationPaths} from './app.constants';
import {HomeComponent} from './shared/home/home.component';
import {DocsApiComponent} from './shared/docs-api/docs-api.component';

const routes: Routes = [
  {path: ApplicationPaths.Home, component: HomeComponent, pathMatch: 'full'},
  {path: ApplicationPaths.Api, component: DocsApiComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {
}
