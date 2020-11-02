import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {HttpClientModule} from '@angular/common/http';

import {CrimeaComponent} from './crimea/crimea.component';
import {ConversationMessagesRoutingModule} from './conversation-messages-routing.module';
import {CrimeaService} from './shared/crimea.service';
import {CoreComponent} from './core/core.component';

@NgModule({
  declarations: [
    CrimeaComponent,
    CoreComponent
  ],
  imports: [
    CommonModule,
    HttpClientModule,
    ConversationMessagesRoutingModule
  ],
  providers: [CrimeaService],
  exports: [
    CrimeaComponent,
    CoreComponent
  ]
})
export class ConversationMessagesModule {
}
