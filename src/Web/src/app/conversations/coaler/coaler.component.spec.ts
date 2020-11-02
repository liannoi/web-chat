import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {CoalerComponent} from './coaler.component';

describe('CoalerComponent', () => {
  let component: CoalerComponent;
  let fixture: ComponentFixture<CoalerComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [CoalerComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CoalerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
