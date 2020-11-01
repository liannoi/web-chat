import {FormGroup, ValidationErrors, ValidatorFn} from '@angular/forms';

export const unauthorizedValidator: ValidatorFn = (control: FormGroup): ValidationErrors | null => {
  const userName = control.get('username');
  const password = control.get('password');

  return userName.invalid || password.invalid ? {unauthorized: true} : null;
};
