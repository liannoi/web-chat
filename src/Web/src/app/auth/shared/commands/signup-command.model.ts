import {UserModel} from '../models/user.model';
import {JwtTokenModel} from '../models/jwt-token.model';

export class SignupCommand {
  public constructor(public user: UserModel) {
  }
}

export interface OnSignup {
  onSignupSuccess(token: JwtTokenModel): void;

  onSignupFailed(error: any): void;
}
