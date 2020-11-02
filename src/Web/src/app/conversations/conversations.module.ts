import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';

import {ConversationsRoutingModule} from './conversations-routing.module';
import {CoalerComponent} from './coaler/coaler.component';
import {CoalerService} from './shared/coaler.service';
import {HttpClientModule} from '@angular/common/http';
import {ConversationMessagesModule} from '../conversation-messages/conversation-messages.module';

@NgModule({
  declarations: [CoalerComponent],
  imports: [
    CommonModule,
    HttpClientModule,
    ConversationMessagesModule,
    ConversationsRoutingModule
  ],
  providers: [CoalerService],
  exports: [CoalerComponent]
})
export class ConversationsModule {
}
