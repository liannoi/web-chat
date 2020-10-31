const applicationNamings: ApplicationNamings = {
  Application: 'Web Chat',
  UserJwtToken: 'user_token'
};

const applicationPaths: ApplicationPaths = {
  Home: '',
  Api: 'docs/api',
  App: 'app',
  Login: 'auth/login',
  Signup: 'auth/signup',
  Profile: 'auth/profile',
  Logout: 'auth/logout',
  NotFound: '**'
};

interface ApplicationNamings {
  readonly Application: string;
  readonly UserJwtToken: string;
}

interface ApplicationPaths {
  readonly Home: string;
  readonly Api: string;
  readonly App: string;
  readonly Login: string;
  readonly Signup: string;
  readonly Profile: string;
  readonly Logout: string;
  readonly NotFound: string;
}

export const ApplicationNamings: ApplicationNamings = applicationNamings;
export const ApplicationPaths: ApplicationPaths = applicationPaths;
