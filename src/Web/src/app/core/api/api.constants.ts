const BaseAddress = 'https://localhost:5001';
const ApiBaseAddress = `${BaseAddress}/api`;

const ApiControllers = {
  Users: 'users'
};

const UsersEndpoint = `${ApiBaseAddress}/${ApiControllers.Users}`;

const apiEndpoints: ApiEndpoints = {
  UsersLogin: `${UsersEndpoint}/login`,
  UsersVerify: `${UsersEndpoint}/verify`,
  UsersSignup: `${UsersEndpoint}/signup`,
};

interface ApiEndpoints {
  readonly UsersLogin: string;
  readonly UsersVerify: string;
  readonly UsersSignup: string;
}

export const ApiEndpoints: ApiEndpoints = apiEndpoints;
