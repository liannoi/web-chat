export const ApplicationName = 'Web Chat';
export const UserJwtTokenName = 'user_token';

interface ApplicationPaths {
  readonly Home: string;
  readonly Api: string;
  readonly App: string;
  readonly Login: string;
  readonly Signup: string;
  readonly Profile: string;
  readonly Logout: string;
}

const applicationPaths: ApplicationPaths = {
  Home: `/`,
  Api: `api`,
  App: `app`,
  Login: `auth/login`,
  Signup: `auth/signup`,
  Profile: `profile`,
  Logout: `auth/logout`,
};

export const ApplicationPaths: ApplicationPaths = applicationPaths;
