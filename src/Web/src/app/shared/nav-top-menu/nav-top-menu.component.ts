import {Component} from '@angular/core';

import {ApplicationPaths} from '../app.constants';
import {AuthService} from '../../core/auth.service';

@Component({
  selector: 'app-nav-top-menu',
  templateUrl: './nav-top-menu.component.html',
  styleUrls: ['./nav-top-menu.component.css']
})
export class NavTopMenuComponent {
  public isExpanded = true;
  public paths = ApplicationPaths;

  public constructor(private authService: AuthService) {
  }

  public verifiedToken(): boolean {
    return this.authService.checkToken();
  }
}
