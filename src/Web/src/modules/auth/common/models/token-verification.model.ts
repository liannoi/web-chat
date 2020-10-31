import {LoginModel} from './login.model';

export interface OnTokenVerification {
  OnTokenVerificationSuccess(user: LoginModel): void;

  OnTokenVerificationFailed(error: any): void;
}
