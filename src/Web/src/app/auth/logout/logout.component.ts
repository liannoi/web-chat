import {Component, OnInit} from '@angular/core';
import {Router} from '@angular/router';

import {AuthService} from '../../core/auth.service';
import {ApplicationPaths} from '../../shared/app.constants';

@Component({
  selector: 'app-logout',
  templateUrl: './logout.component.html',
  styleUrls: ['./logout.component.css']
})
export class LogoutComponent implements OnInit {
  public constructor(private authService: AuthService, private router: Router) {
  }

  public ngOnInit() {
    this.authService.clearToken();
    this.router.navigate([ApplicationPaths.Home]);
  }
}
