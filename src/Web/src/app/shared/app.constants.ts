const applicationNamings: ApplicationNamings = {
  Application: 'Web Chat',
  UserJwtToken: 'user_token'
};

const applicationPaths: ApplicationPaths = {
  Home: '',
  Chat: 'app',
  Contacts: 'contacts',
  DocsApi: 'docs/api',
  Login: 'auth/login',
  Signup: 'auth/signup',
  Profile: 'auth/profile',
  Logout: 'auth/logout',
  StatusNotFound: '**'
};

interface ApplicationNamings {
  readonly Application: string;
  readonly UserJwtToken: string;
}

interface ApplicationPaths {
  readonly Home: string;
  readonly Chat: string;
  readonly Contacts: string;
  readonly DocsApi: string;
  readonly Login: string;
  readonly Signup: string;
  readonly Profile: string;
  readonly Logout: string;
  readonly StatusNotFound: string;
}

export const ApplicationNamings: ApplicationNamings = applicationNamings;
export const ApplicationPaths: ApplicationPaths = applicationPaths;
