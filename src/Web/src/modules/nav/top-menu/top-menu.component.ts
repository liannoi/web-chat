import {Component} from '@angular/core';

import {ApplicationPaths} from '../../../app/app.constants';
import {AuthService} from '../../auth/auth.service';

@Component({
  selector: 'app-top-menu',
  templateUrl: './top-menu.component.html',
  styleUrls: ['./top-menu.component.css']
})
export class TopMenuComponent {
  public isExpanded = true;
  public paths = ApplicationPaths;

  public constructor(private authService: AuthService) {
  }

  public verifiedToken(): boolean {
    return this.authService.checkToken();
  }
}
