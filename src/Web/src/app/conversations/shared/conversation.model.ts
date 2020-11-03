import {UserModel} from '../../auth/shared/user.model';

export class ConversationModel {
  public constructor(public conversationId: number = 0,
                     public leftUser: UserModel = new UserModel(),
                     public rightUser: UserModel = new UserModel()) {
  }
}
