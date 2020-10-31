import {TestBed} from '@angular/core/testing';

import {TokenVerifierService} from './token-verifier.service';

describe('TokenVerifierService', () => {
  let service: TokenVerifierService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(TokenVerifierService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
