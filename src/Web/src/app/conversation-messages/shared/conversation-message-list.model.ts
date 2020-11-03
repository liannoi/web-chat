import {ConversationMessageModel} from './conversation-message.model';

export class ConversationMessageListModel {
  public constructor(public messages: ConversationMessageModel[] = []) {
  }
}
