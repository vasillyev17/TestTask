import { ComponentFixture, TestBed } from '@angular/core/testing';

import { InputDataComponent } from './inputdata.component';

describe('InputDataComponent', () => {
  let component: InputDataComponent;
  let fixture: ComponentFixture<InputDataComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [InputDataComponent]
    })
      .compileComponents();

    fixture = TestBed.createComponent(InputDataComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
