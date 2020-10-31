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
import {StatusNotFoundComponent} from './shared/status-not-found/status-not-found.component';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    DocsApiComponent,
    NavTopMenuComponent,
    NavFooterComponent,
    StatusNotFoundComponent
  ],
  imports: [
    CommonModule,
    BrowserModule,
    NgbModule,
    AuthModule,
    ChatModule,
    AppRoutingModule
  ],
  exports: [
    AppComponent,
    HomeComponent,
    DocsApiComponent,
    NavTopMenuComponent,
    NavFooterComponent,
    StatusNotFoundComponent
  ],
  bootstrap: [AppComponent]
})
export class AppModule {
}
