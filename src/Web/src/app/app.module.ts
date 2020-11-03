import {NgModule} from '@angular/core';
import {BrowserModule} from '@angular/platform-browser';
import {CommonModule} from '@angular/common';
import {ReactiveFormsModule} from '@angular/forms';

import {NgbModule} from '@ng-bootstrap/ng-bootstrap';

import {AppComponent} from './app.component';
import {HomeComponent} from './shared/home/home.component';
import {AppRoutingModule} from './app-routing.module';
import {NavFooterComponent} from './shared/nav-footer/nav-footer.component';
import {NavTopMenuComponent} from './shared/nav-top-menu/nav-top-menu.component';
import {AuthModule} from './auth/auth.module';
import {StatusesModule} from './statuses/statuses.module';
import {ContactsModule} from './contacts/contacts.module';
import {DocsModule} from './docs/docs.module';
import {ChatComponent} from './shared/chat/chat.component';
import {ConversationsModule} from './conversations/conversations.module';
import {ConversationMessagesModule} from './conversation-messages/conversation-messages.module';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    NavTopMenuComponent,
    NavFooterComponent,
    ChatComponent
  ],
  imports: [
    CommonModule,
    BrowserModule,
    NgbModule,
    AuthModule,
    DocsModule,
    ContactsModule,
    ConversationsModule,
    ConversationMessagesModule,
    AppRoutingModule,
    StatusesModule,
    ReactiveFormsModule,
  ],
  exports: [
    AppComponent,
    HomeComponent,
    NavTopMenuComponent,
    NavFooterComponent,
    ChatComponent
  ],
  bootstrap: [AppComponent]
})
export class AppModule {
}
