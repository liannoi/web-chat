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

const routes: Routes = [
  {path: ApplicationPaths.Login, component: LoginComponent},
  {path: ApplicationPaths.Signup, component: SignupComponent}
];

@NgModule({
  declarations: [
    LoginComponent,
    SignupComponent
  ],
  imports: [
    CommonModule,
    HttpClientModule,
    ReactiveFormsModule,
    RouterModule.forChild(routes)
  ],
  exports: [
    LoginComponent,
    SignupComponent
  ],
  providers: [
    AuthService,
    CookieService
  ],
})
export class AuthModule {
}
