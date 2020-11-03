import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {HttpClientModule} from '@angular/common/http';

import {CrimeaComponent} from './crimea/crimea.component';
import {ConversationMessagesRoutingModule} from './conversation-messages-routing.module';
import {CrimeaService} from './shared/crimea.service';
import {ConversationMessageComponent} from './conversation-message/conversation-message.component';
import {ConversationMessageService} from './shared/conversation-message.service';

@NgModule({
  declarations: [
    CrimeaComponent,
    ConversationMessageComponent
  ],
  imports: [
    CommonModule,
    HttpClientModule,
    ConversationMessagesRoutingModule
  ],
  providers: [
    ConversationMessageService,
    CrimeaService
  ],
  exports: [
    CrimeaComponent,
    ConversationMessageComponent
  ]
})
export class ConversationMessagesModule {
}
