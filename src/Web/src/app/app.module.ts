import {NgModule} from '@angular/core';
import {BrowserModule} from '@angular/platform-browser';
import {CommonModule} from '@angular/common';

import {NgbModule} from '@ng-bootstrap/ng-bootstrap';

import {AppComponent} from './app.component';
import {HomeComponent} from './shared/home/home.component';
import {AppRoutingModule} from './app-routing.module';
import {NavFooterComponent} from './shared/nav-footer/nav-footer.component';
import {NavTopMenuComponent} from './shared/nav-top-menu/nav-top-menu.component';
import {AuthModule} from './auth/auth.module';
import {ChatModule} from './chat/chat.module';
import {StatusesModule} from './statuses/statuses.module';
import {ContactsModule} from './contacts/contacts.module';
import {DocsModule} from './docs/docs.module';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    NavTopMenuComponent,
    NavFooterComponent
  ],
  imports: [
    CommonModule,
    BrowserModule,
    NgbModule,
    AuthModule,
    ChatModule,
    DocsModule,
    ContactsModule,
    AppRoutingModule,
    StatusesModule,
  ],
  exports: [
    AppComponent,
    HomeComponent,
    NavTopMenuComponent,
    NavFooterComponent
  ],
  bootstrap: [AppComponent]
})
export class AppModule {
}
