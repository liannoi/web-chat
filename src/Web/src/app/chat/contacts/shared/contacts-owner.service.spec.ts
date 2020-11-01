import {TestBed} from '@angular/core/testing';

import {ContactsOwnerService} from './contacts-owner.service';

describe('ContactService', () => {
  let service: ContactsOwnerService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ContactsOwnerService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
