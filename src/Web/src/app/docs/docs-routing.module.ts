import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';

import {ApplicationPaths} from '../shared/app.constants';
import {ApiDocsComponent} from './api-docs/api-docs.component';

const routes: Routes = [
  {path: ApplicationPaths.DocsApi, component: ApiDocsComponent}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DocsRoutingModule {
}
