import {NgModule} from '@angular/core';

import {ChatComponent} from './chat.component';
import {ChatRoutingModule} from './chat-routing.module';

@NgModule({
  declarations: [ChatComponent],
  imports: [ChatRoutingModule],
  exports: [ChatComponent]
})
export class ChatModule {
}
