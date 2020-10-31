import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {StatusNotFoundComponent} from './status-not-found.component';

describe('StatusNotFoundComponent', () => {
  let component: StatusNotFoundComponent;
  let fixture: ComponentFixture<StatusNotFoundComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [StatusNotFoundComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(StatusNotFoundComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
