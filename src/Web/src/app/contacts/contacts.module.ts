import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';

import {ContactsOwnerComponent} from './contacts-owner/contacts-owner.component';
import {ContactsRoutingModule} from './contacts-routing.module';
import {ContactsOwnerService} from './shared/contacts-owner.service';

@NgModule({
  declarations: [ContactsOwnerComponent],
  imports: [
    CommonModule,
    ContactsRoutingModule
  ],
  providers: [ContactsOwnerService],
  exports: [ContactsOwnerComponent]
})
export class ContactsModule {
}
