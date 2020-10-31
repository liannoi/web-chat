import {NgModule} from '@angular/core';
import {BrowserModule} from '@angular/platform-browser';
import {CommonModule} from '@angular/common';

import {NgbModule} from '@ng-bootstrap/ng-bootstrap';

import {AppComponent} from './app.component';
import {HomeComponent} from './shared/home/home.component';
import {DocsApiComponent} from './shared/docs-api/docs-api.component';
import {AppRoutingModule} from './app-routing.module';
import {NavFooterComponent} from './shared/nav-footer/nav-footer.component';
import {NavTopMenuComponent} from './shared/nav-top-menu/nav-top-menu.component';
import {AuthModule} from './auth/auth.module';
import {ChatModule} from './chat/chat.module';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    DocsApiComponent,
    NavTopMenuComponent,
    NavFooterComponent
  ],
  imports: [
    CommonModule,
    BrowserModule,
    NgbModule,
    AppRoutingModule,
    AuthModule,
    ChatModule
  ],
  exports: [
    AppComponent,
    HomeComponent,
    DocsApiComponent,
    NavTopMenuComponent,
    NavFooterComponent
  ],
  bootstrap: [AppComponent]
})
export class AppModule {
}
