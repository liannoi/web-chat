import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';

import {ApplicationPaths} from './shared/app.constants';
import {HomeComponent} from './shared/home/home.component';
import {ChatComponent} from './shared/chat/chat.component';

const routes: Routes = [
  {path: ApplicationPaths.Home, component: HomeComponent, pathMatch: 'full'},
  {path: ApplicationPaths.Chat, component: ChatComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {
}
