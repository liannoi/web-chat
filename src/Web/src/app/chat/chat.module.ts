import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';

import {ChatComponent} from './chat.component';
import {ChatRoutingModule} from './chat-routing.module';

@NgModule({
  declarations: [ChatComponent],
  imports: [
    CommonModule,
    ChatRoutingModule,
  ],
  exports: [ChatComponent]
})
export class ChatModule {
}
