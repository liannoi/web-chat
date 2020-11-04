const BaseAddress = 'https://localhost:5001';
const BaseApiAddress = `${BaseAddress}/api`;

const UsersController = `${BaseApiAddress}/users`;
const CrimeaController = `${BaseApiAddress}/crimea`;

const apiEndpoints: ApiEndpoints = {
  UserLogin: `${UsersController}/login`,
  UserVerify: `${UsersController}/verify`,
  UserSignup: `${UsersController}/signup`,
  ContactsOwner: `${BaseApiAddress}/contactsowner`,
  ConversationMessages: `${BaseApiAddress}/conversationmessages`,
  CrimeaGetAll: `${CrimeaController}/getAll`,
  CrimeaGetById: `${CrimeaController}/getById`,
  Notifications: `${BaseAddress}/notifications`,
  Conversations: `${BaseApiAddress}/conversations`,
  Coaler: `${BaseApiAddress}/coaler`
};

interface ApiEndpoints {
  readonly UserLogin: string;
  readonly UserVerify: string;
  readonly UserSignup: string;
  readonly ContactsOwner: string;
  readonly ConversationMessages: string;
  readonly CrimeaGetAll: string;
  readonly CrimeaGetById: string;
  readonly Notifications: string;
  readonly Conversations: string;
  readonly Coaler: string;
}

export const ApiEndpoints: ApiEndpoints = apiEndpoints;
