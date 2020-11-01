import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';

import {ApplicationPaths} from './shared/app.constants';
import {HomeComponent} from './shared/home/home.component';

const routes: Routes = [
  {path: ApplicationPaths.Home, component: HomeComponent, pathMatch: 'full'}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {
}
