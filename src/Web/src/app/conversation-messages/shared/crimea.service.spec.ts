import {TestBed} from '@angular/core/testing';

import {CrimeaService} from './crimea.service';

describe('ConversationMessageService', () => {
  let service: CrimeaService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(CrimeaService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
