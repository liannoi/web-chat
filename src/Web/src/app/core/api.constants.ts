const BaseApiAddress = 'https://localhost:5001/api';
const UsersEndpoint = `${BaseApiAddress}/users`;

const apiEndpoints: ApiEndpoints = {
  UsersLogin: `${UsersEndpoint}/login`,
  UsersVerify: `${UsersEndpoint}/verify`,
  UsersSignup: `${UsersEndpoint}/signup`
};

interface ApiEndpoints {
  readonly UsersLogin: string;
  readonly UsersVerify: string;
  readonly UsersSignup: string;
}

export const ApiEndpoints: ApiEndpoints = apiEndpoints;
