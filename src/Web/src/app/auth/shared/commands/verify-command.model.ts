import {JwtTokenModel} from '../models/jwt-token.model';
import {UserModel} from '../models/user.model';

export class VerifyCommand {
  public constructor(public token: JwtTokenModel) {
  }
}

export interface OnVerified {
  onVerifiedSuccess(user: UserModel): void;

  onVerifiedFailed(error: any): void;
}
