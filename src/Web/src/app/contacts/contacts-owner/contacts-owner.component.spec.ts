import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {ContactsOwnerComponent} from './contacts-owner.component';

describe('ContactsListComponent', () => {
  let component: ContactsOwnerComponent;
  let fixture: ComponentFixture<ContactsOwnerComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ContactsOwnerComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ContactsOwnerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
