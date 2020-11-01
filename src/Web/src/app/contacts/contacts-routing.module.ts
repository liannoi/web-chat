import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';

import {ApplicationPaths} from '../shared/app.constants';
import {ContactsOwnerComponent} from './contacts-owner/contacts-owner.component';

const routes: Routes = [
  {path: ApplicationPaths.Contacts, component: ContactsOwnerComponent}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ContactsRoutingModule {
}
