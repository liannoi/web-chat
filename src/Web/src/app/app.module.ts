import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';

import {AppRoutingModule} from './app-routing.module';
import {AppComponent} from './app.component';
import {AuthModule} from '../modules/auth/auth.module';
import {HomeComponent} from './home/home.component';
import {NavModule} from '../modules/nav/nav.module';
import {ApiComponent} from './api/api.component';
import {ChatComponent} from './chat/chat.component';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    ApiComponent,
    ChatComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    AuthModule,
    NavModule
  ],
  bootstrap: [AppComponent]
})
export class AppModule {
}
