import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {ConversationMessageComponent} from './conversation-message.component';

describe('CoreComponent', () => {
  let component: ConversationMessageComponent;
  let fixture: ComponentFixture<ConversationMessageComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ConversationMessageComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ConversationMessageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
