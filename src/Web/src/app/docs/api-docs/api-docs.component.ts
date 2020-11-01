import {Component} from '@angular/core';
import {Title} from '@angular/platform-browser';

import {ApplicationNamings} from '../../shared/app.constants';

@Component({
  selector: 'app-api-docs',
  templateUrl: './api-docs.component.html',
  styleUrls: ['./api-docs.component.css']
})
export class ApiDocsComponent {
  public constructor(private titleService: Title) {
    titleService.setTitle(`${ApplicationNamings.Application} APIs`);
  }
}
