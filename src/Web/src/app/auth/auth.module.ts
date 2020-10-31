import {NgModule} from '@angular/core';
import {HttpClientModule} from '@angular/common/http';
import {ReactiveFormsModule} from '@angular/forms';
import {CommonModule} from '@angular/common';

import {CookieService} from 'ngx-cookie-service';

import {LoginComponent} from './login/login.component';
import {AuthService} from '../core/auth.service';
import {SignupComponent} from './signup/signup.component';
import {LogoutComponent} from './logout/logout.component';
import {AuthRoutingModule} from './auth-routing.module';
import {ProfileComponent} from './profile/profile.component';

@NgModule({
  declarations: [
    LoginComponent,
    LogoutComponent,
    ProfileComponent,
    SignupComponent
  ],
  imports: [
    CommonModule,
    HttpClientModule,
    ReactiveFormsModule,
    AuthRoutingModule
  ],
  exports: [
    LoginComponent,
    LogoutComponent,
    ProfileComponent,
    SignupComponent
  ],
  providers: [
    AuthService,
    CookieService
  ],
})
export class AuthModule {
}
