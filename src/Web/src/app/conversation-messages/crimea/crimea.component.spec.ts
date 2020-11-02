import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {CrimeaComponent} from './crimea.component';

describe('CrimeaComponent', () => {
  let component: CrimeaComponent;
  let fixture: ComponentFixture<CrimeaComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [CrimeaComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CrimeaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
