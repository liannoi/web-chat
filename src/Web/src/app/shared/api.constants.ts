const BaseApiAddress = 'https://localhost:5001/api';
const UsersEndpoint = `${BaseApiAddress}/users`;

const apiEndpoints: ApiEndpoints = {
  UsersLogin: `${UsersEndpoint}/login`,
  UsersVerify: `${UsersEndpoint}/verify`,
  UsersSignup: `${UsersEndpoint}/signup`,
  ContactsOwner: `${BaseApiAddress}/contactsowner`,
  Coaler: `${BaseApiAddress}/coaler`,
  Crimea: `${BaseApiAddress}/crimea`
};

interface ApiEndpoints {
  readonly UsersLogin: string;
  readonly UsersVerify: string;
  readonly UsersSignup: string;
  readonly ContactsOwner: string;
  readonly Coaler: string;
  readonly Crimea: string;
}

export const ApiEndpoints: ApiEndpoints = apiEndpoints;
