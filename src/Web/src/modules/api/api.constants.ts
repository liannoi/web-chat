export const BaseAddress = 'https://localhost:5001';
export const ApiBaseAddress = `${BaseAddress}/api`;

export const ApiControllers = {
  Users: 'users'
};

interface ApiEndpoints {
  readonly UsersLogin: string;
  readonly UsersVerify: string;
}

const UsersEndpoint = `${ApiBaseAddress}/${ApiControllers.Users}`;

const apiEndpoints: ApiEndpoints = {
  UsersLogin: `${UsersEndpoint}/login`,
  UsersVerify: `${UsersEndpoint}/verify`,
};

export const ApiEndpoints: ApiEndpoints = apiEndpoints;
