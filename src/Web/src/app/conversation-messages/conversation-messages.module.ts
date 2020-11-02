import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';

import {CrimeaComponent} from './crimea/crimea.component';
import {ConversationMessagesRoutingModule} from './conversation-messages-routing.module';
import {ConversationMessageService} from './shared/conversation-message.service';
import {HttpClientModule} from '@angular/common/http';

@NgModule({
  declarations: [CrimeaComponent],
  imports: [
    CommonModule,
    HttpClientModule,
    ConversationMessagesRoutingModule
  ],
  providers: [ConversationMessageService],
  exports: [CrimeaComponent]
})
export class ConversationMessagesModule {
}
