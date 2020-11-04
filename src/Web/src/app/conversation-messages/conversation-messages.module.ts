import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {HttpClientModule} from '@angular/common/http';

import {CrimeaComponent} from './crimea/crimea.component';
import {ConversationMessagesRoutingModule} from './conversation-messages-routing.module';
import {CrimeaService} from './shared/crimea.service';
import {ConversationMessageComponent} from './conversation-message/conversation-message.component';
import {ConversationMessageService} from './shared/conversation-message.service';
import {NotificationService} from '../core/notification.service';

@NgModule({
  declarations: [
    ConversationMessageComponent,
    CrimeaComponent
  ],
  imports: [
    CommonModule,
    HttpClientModule,
    ConversationMessagesRoutingModule
  ],
  providers: [
    ConversationMessageService,
    CrimeaService,
    NotificationService
  ],
  exports: [
    ConversationMessageComponent,
    CrimeaComponent
  ]
})
export class ConversationMessagesModule {
}
