import {Component} from '@angular/core';
import {Title} from '@angular/platform-browser';

import {ApplicationNamings} from '../app.constants';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent {
  public constructor(private titleService: Title) {
    titleService.setTitle(ApplicationNamings.Application);
  }
}
