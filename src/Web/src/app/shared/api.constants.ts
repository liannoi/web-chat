const BaseAddress = 'https://localhost:5001';
const BaseApiAddress = `${BaseAddress}/api`;
const UsersController = `${BaseApiAddress}/users`;
const CrimeaController = `${BaseApiAddress}/crimea`;

const apiEndpoints: ApiEndpoints = {
  UserLogin: `${UsersController}/login`,
  UserVerify: `${UsersController}/verify`,
  UserSignup: `${UsersController}/signup`,
  ContactsOwner: `${BaseApiAddress}/contactsowner`,
  Coaler: `${BaseApiAddress}/coaler`,
  ConversationMessages: `${BaseApiAddress}/conversationmessages`,
  CrimeaGetById: `${CrimeaController}/getById`,
  CrimeaGetAll: `${CrimeaController}/getAll`,
  Notifications: `${BaseAddress}/notifications`
};

interface ApiEndpoints {
  readonly UserLogin: string;
  readonly UserVerify: string;
  readonly UserSignup: string;
  readonly ContactsOwner: string;
  readonly Coaler: string;
  readonly ConversationMessages: string;
  readonly CrimeaGetById: string;
  readonly CrimeaGetAll: string;
  readonly Notifications: string;
}

export const ApiEndpoints: ApiEndpoints = apiEndpoints;
