interface ApplicationPathsType {
  readonly Login: string;
}

export const LoginActions = {
  Login: 'login',
};

const applicationPaths: ApplicationPathsType = {
  Login: `auth/${LoginActions.Login}`,
};

export const ApplicationPaths: ApplicationPathsType = applicationPaths;
