import {Component} from '@angular/core';
import {Title} from '@angular/platform-browser';

import {ApplicationNamings} from '../../app.constants';

@Component({
  selector: 'app-status-not-found',
  templateUrl: './status-not-found.component.html',
  styleUrls: ['./status-not-found.component.css']
})
export class StatusNotFoundComponent {
  public constructor(private titleService: Title) {
    titleService.setTitle(`Page Not Found - ${ApplicationNamings.Application}`);
  }
}
