const applicationNamings: ApplicationNamings = {
  Application: 'Web Chat',
  UserJwtToken: 'user_token'
};

const applicationPaths: ApplicationPaths = {
  Home: '',
  Login: 'auth/login',
  Logout: 'auth/logout',
  Profile: 'auth/profile',
  Signup: 'auth/signup',
  Chat: 'app',
  Contacts: 'contacts',
  DocsApi: 'docs/api',
  StatusNotFound: '**'
};

interface ApplicationNamings {
  readonly Application: string;
  readonly UserJwtToken: string;
}

interface ApplicationPaths {
  readonly Home: string;
  readonly Login: string;
  readonly Logout: string;
  readonly Profile: string;
  readonly Signup: string;
  readonly Chat: string;
  readonly Contacts: string;
  readonly DocsApi: string;
  readonly StatusNotFound: string;
}

export const ApplicationNamings: ApplicationNamings = applicationNamings;
export const ApplicationPaths: ApplicationPaths = applicationPaths;
