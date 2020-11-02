import {TestBed} from '@angular/core/testing';

import {CoalerService} from './coaler.service';

describe('CoalerService', () => {
  let service: CoalerService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(CoalerService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
