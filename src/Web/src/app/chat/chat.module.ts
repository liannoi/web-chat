import {NgModule} from '@angular/core';

import {ChatComponent} from './chat.component';
import {ChatRoutingModule} from './chat-routing.module';
import {ContactsOwnerComponent} from './contacts/contacts-owner/contacts-owner.component';
import {ContactsOwnerService} from './contacts/shared/contacts-owner.service';

@NgModule({
  declarations: [
    ChatComponent,
    ContactsOwnerComponent
  ],
  imports: [ChatRoutingModule],
  providers: [ContactsOwnerService],
  exports: [
    ChatComponent,
    ContactsOwnerComponent
  ]
})
export class ChatModule {
}
