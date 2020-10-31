import {UserModel} from '../models/user.model';
import {JwtTokenModel} from '../models/jwt-token.model';

export class LoginCommand {
  public constructor(public user: UserModel) {
  }
}

export interface OnLogin {
  onLoginSuccess(token: JwtTokenModel): void;

  onLoginFailed(error: any): void;
}
