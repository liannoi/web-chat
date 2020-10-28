export const BaseAddress = 'https://localhost:5001';
export const ApiBaseAddress = `${BaseAddress}/api`;

export const ApiControllers = {
  Users: 'users'
};

interface ApiEndpoints {
  readonly UsersLogin: string;
}

const apiEndpoints: ApiEndpoints = {
  UsersLogin: `${ApiBaseAddress}/${ApiControllers.Users}/login`,
};

export const ApiEndpoints: ApiEndpoints = apiEndpoints;
