import {Component} from '@angular/core';
import {Title} from '@angular/platform-browser';

import {ApplicationNamings} from '../../app.constants';

@Component({
  selector: 'app-docs-api',
  templateUrl: './docs-api.component.html',
  styleUrls: ['./docs-api.component.css']
})
export class DocsApiComponent {
  public constructor(private titleService: Title) {
    titleService.setTitle(`${ApplicationNamings.Application} APIs`);
  }
}
