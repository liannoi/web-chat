import {Component, OnDestroy, OnInit} from '@angular/core';
import {Subject} from 'rxjs';
import {Title} from '@angular/platform-browser';
import {Router} from '@angular/router';
import {AuthService} from '../../modules/auth/auth.service';
import {ApplicationName} from '../app.constants';
import {TokenVerifierService} from '../../modules/auth/common/services/token-verifier.service';
import {OnTokenVerification} from '../../modules/auth/common/models/token-verification.model';
import {LoginModel} from '../../modules/auth/common/models/login.model';

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit, OnDestroy, OnTokenVerification {
  public constructor(private titleService: Title,
                     private router: Router,
                     private authService: AuthService,
                     private tokenVerifier: TokenVerifierService) {
    titleService.setTitle(`Your profile - ${ApplicationName}`);
  }

  public ngOnInit() {
    this.tokenVerifier.verify(this);
  }

  public OnTokenVerificationSuccess(user: LoginModel): void {
    console.log(user);
  }

  public OnTokenVerificationFailed(error: any): void {
    console.error(error);
    this.authService.clearToken();
    this.tokenVerifier.redirectToLogin();
  }

  public ngOnDestroy() {
    this.tokenVerifier.stop$.next();
    this.tokenVerifier.stop$.complete();
  }
}
