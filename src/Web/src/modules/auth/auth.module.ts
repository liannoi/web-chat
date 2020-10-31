import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {HttpClientModule} from '@angular/common/http';
import {ReactiveFormsModule} from '@angular/forms';
import {CommonModule} from '@angular/common';

import {CookieService} from 'ngx-cookie-service';

import {LoginComponent} from './login/login.component';
import {ApplicationPaths} from '../../app/app.constants';
import {AuthService} from './auth.service';
import {SignupComponent} from './signup/signup.component';
import {LogoutComponent} from './logout/logout.component';
import {TokenVerifierService} from './common/services/token-verifier.service';

const routes: Routes = [
  {path: ApplicationPaths.Login, component: LoginComponent},
  {path: ApplicationPaths.Signup, component: SignupComponent},
  {path: ApplicationPaths.Logout, component: LogoutComponent}
];

@NgModule({
  declarations: [
    LoginComponent,
    SignupComponent,
    LogoutComponent
  ],
  imports: [
    CommonModule,
    HttpClientModule,
    ReactiveFormsModule,
    RouterModule.forChild(routes)
  ],
  exports: [
    LoginComponent,
    SignupComponent,
    LogoutComponent
  ],
  providers: [
    AuthService,
    CookieService,
    TokenVerifierService
  ],
})
export class AuthModule {
}
