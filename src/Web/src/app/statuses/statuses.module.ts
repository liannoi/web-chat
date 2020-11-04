import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';

import {NotFoundComponent} from './not-found/not-found.component';
import {StatusesRoutingModule} from './statuses-routing.module';

@NgModule({
  declarations: [NotFoundComponent],
  imports: [
    CommonModule,
    StatusesRoutingModule
  ]
})
export class StatusesModule {
}
