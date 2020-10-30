import {NgModule} from '@angular/core';
import {RouterModule} from '@angular/router';
import {CommonModule} from '@angular/common';

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
    NgbModule,
    CommonModule
  ],
  exports: [
    TopMenuComponent,
    FooterComponent
  ]
})
export class NavModule {
}
