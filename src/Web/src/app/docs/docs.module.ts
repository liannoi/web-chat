import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';

import {DocsRoutingModule} from './docs-routing.module';
import {ApiDocsComponent} from './api-docs/api-docs.component';

@NgModule({
  declarations: [ApiDocsComponent],
  imports: [
    DocsRoutingModule,
    CommonModule
  ],
  exports: [ApiDocsComponent]
})
export class DocsModule {
}
