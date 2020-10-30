import {NgModule} from '@angular/core';
import {RouterModule} from '@angular/router';

import {NgbModule} from '@ng-bootstrap/ng-bootstrap';

import {TopMenuComponent} from './top-menu/top-menu.component';
import {FooterComponent} from './footer/footer.component';

@NgModule({
  declarations: [
    TopMenuComponent,
    FooterComponent
  ],
  imports: [
    RouterModule,
    NgbModule
  ],
  exports: [
    TopMenuComponent,
    FooterComponent
  ]
})
export class NavModule {
}
