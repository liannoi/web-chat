import {Component} from '@angular/core';
import {Title} from '@angular/platform-browser';

import {ApplicationName} from '../app.constants';

@Component({
  selector: 'app-api',
  templateUrl: './api.component.html',
  styleUrls: ['./api.component.css']
})
export class ApiComponent {
  public constructor(private titleService: Title) {
    titleService.setTitle(`${ApplicationName} APIs`);
  }
}
