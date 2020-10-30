export const ApplicationName = 'Web Chat';
export const UserJwtTokenName = 'user_token';

interface ApplicationPaths {
  readonly Api: string;
  readonly App: string;
  readonly Login: string;
  readonly Signup: string;
}

const applicationPaths: ApplicationPaths = {
  Api: `api`,
  App: `app`,
  Login: `auth/login`,
  Signup: `auth/signup`,
};

export const ApplicationPaths: ApplicationPaths = applicationPaths;
