import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {RouterModule, Routes} from '@angular/router';
import {HttpClientModule} from '@angular/common/http';
import {ReactiveFormsModule} from '@angular/forms';

import {LoginComponent} from './login/login.component';
import {ApplicationPaths} from './auth.constants';
import {AuthService} from './auth.service';

const routes: Routes = [
  {path: ApplicationPaths.Login, component: LoginComponent}
];

@NgModule({
  declarations: [LoginComponent],
  imports: [
    CommonModule,
    HttpClientModule,
    ReactiveFormsModule,
    RouterModule.forChild(routes)
  ],
  exports: [LoginComponent],
  providers: [AuthService]
})
export class AuthModule {
}
