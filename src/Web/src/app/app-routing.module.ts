import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';

import {HomeComponent} from './home/home.component';
import {ApiComponent} from './api/api.component';
import {ChatComponent} from './chat/chat.component';
import {ProfileComponent} from './profile/profile.component';
import {ApplicationPaths} from './app.constants';

const routes: Routes = [
  {path: '', component: HomeComponent, pathMatch: 'full'},
  {path: ApplicationPaths.Api, component: ApiComponent},
  {path: ApplicationPaths.App, component: ChatComponent},
  {path: ApplicationPaths.Profile, component: ProfileComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {
}
