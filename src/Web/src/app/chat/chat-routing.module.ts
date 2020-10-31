import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';

import {ApplicationPaths} from '../app.constants';
import {ChatComponent} from './chat.component';

const routes: Routes = [
  {path: ApplicationPaths.App, component: ChatComponent}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ChatRoutingModule {
}
