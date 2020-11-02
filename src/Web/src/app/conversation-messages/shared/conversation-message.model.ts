import {ConversationModel} from '../../conversations/shared/conversation.model';

export class ConversationMessageModel {
  public constructor(public conversationMessageId: number = 0,
                     public conversation: ConversationModel = new ConversationModel(),
                     public ownerUserId: number = 0,
                     public message: string = '',
                     public publish: Date = new Date()) {
  }
}
