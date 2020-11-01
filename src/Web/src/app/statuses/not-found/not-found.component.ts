import {Component} from '@angular/core';
import {Title} from '@angular/platform-browser';

import {ApplicationNamings} from '../../shared/app.constants';

@Component({
  selector: 'app-not-found',
  templateUrl: './not-found.component.html',
  styleUrls: ['./not-found.component.css']
})
export class NotFoundComponent {
  public constructor(private titleService: Title) {
    titleService.setTitle(`Page Not Found - ${ApplicationNamings.Application}`);
  }
}
