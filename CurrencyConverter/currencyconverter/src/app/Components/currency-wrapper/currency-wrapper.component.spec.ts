import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CurrencyWrapperComponent } from './currency-wrapper.component';

describe('CurrencyWrapperComponent', () => {
  let component: CurrencyWrapperComponent;
  let fixture: ComponentFixture<CurrencyWrapperComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CurrencyWrapperComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CurrencyWrapperComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
