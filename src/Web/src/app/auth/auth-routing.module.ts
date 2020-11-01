import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';

import {LoginComponent} from './login/login.component';
import {ApplicationPaths} from '../shared/app.constants';
import {LogoutComponent} from './logout/logout.component';
import {ProfileComponent} from './profile/profile.component';
import {SignupComponent} from './signup/signup.component';

const routes: Routes = [
  {path: ApplicationPaths.Login, component: LoginComponent},
  {path: ApplicationPaths.Logout, component: LogoutComponent},
  {path: ApplicationPaths.Profile, component: ProfileComponent},
  {path: ApplicationPaths.Signup, component: SignupComponent}
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AuthRoutingModule {
}
