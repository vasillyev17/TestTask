import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CurrencyConverterComponent } from './currencyconverter.component';

describe('CurrencyconverterComponent', () => {
  let component: CurrencyConverterComponent;
  let fixture: ComponentFixture<CurrencyConverterComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [CurrencyConverterComponent]
    })
      .compileComponents();
    fixture = TestBed.createComponent(CurrencyConverterComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
