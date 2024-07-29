import { Component, OnInit, ViewChild } from '@angular/core';
import { FormGroup, FormControl } from '@angular/forms';
import { NetworkingService } from '../../Services/networking/networking.service';
import { Currency } from 'src/app/models/currency';
import { InputDataComponent } from '../inputdata/inputdata.component';

@Component({
  selector: 'app-currency-wrapper',
  templateUrl: './currency-wrapper.component.html',
  styleUrls: ['./currency-wrapper.component.css']
})
export class CurrencyWrapperComponent implements OnInit {
  @ViewChild('first') first: InputDataComponent | undefined;
  @ViewChild('second') second: InputDataComponent | undefined;
  
  form: FormGroup;
  currencies: string[] = [];
  firstCurrency: Currency | undefined;
  secondCurrency: Currency | undefined;
  rates: any = {};

  constructor(private currencyService: NetworkingService) { 
    this.form = new FormGroup({
      baseAmount: new FormControl({ amount: 1, currency: 'USD' }),
      targetAmount: new FormControl({ amount: 1, currency: 'EUR' }),
    });
  }

  ngOnInit() {
    this.fetchRates();
  }

  firstCurrencyChange(currency: Currency) {
    this.firstCurrency = currency;
    this._convertFromBase();
  }

  secondCurrencyChange(currency: Currency) {
    this.secondCurrency = currency;
    this._convertFromTarget();
  }

  fetchRates() {
    this.currencyService.getUsdRates().subscribe(data => {
      this.rates = data.conversion_rates;
      this.currencies = Object.keys(this.rates);
      this._convertFromBase();
    });
  }

  private _convertFromBase() {
    if (!this.firstCurrency && !this.secondCurrency) {
      return;
    }

    const baseAmount = this.firstCurrency?.Amount || 0;
    const baseCurrency = this.firstCurrency?.Currency;
    const targetCurrency = this.secondCurrency?.Currency;
    
    if (baseCurrency && targetCurrency && this.rates && this.rates[baseCurrency] && this.rates[targetCurrency]) {
      let baseToUsd = 1;
      let usdToTarget = 1;
      
      if (baseCurrency !== 'USD') {
        baseToUsd = 1 / this.rates[baseCurrency];
      }

      if (targetCurrency !== 'USD') {
        usdToTarget = this.rates[targetCurrency];
      }

      const targetAmount = baseAmount * baseToUsd * usdToTarget;
      this.secondCurrency!.Amount = parseFloat(targetAmount.toFixed(5));
      this.second?.patchValue(this.secondCurrency!);
    }
  }

  private _convertFromTarget() {
    if (!this.firstCurrency && !this.secondCurrency) {
      return;
    }

    const targetAmount = this.secondCurrency?.Amount || 0;
    const targetCurrency = this.secondCurrency?.Currency;
    const baseCurrency = this.firstCurrency?.Currency;

    if (baseCurrency && targetCurrency && this.rates && this.rates[baseCurrency] && this.rates[targetCurrency]) {
      let targetToUsd = 1;
      let usdToBase = 1;

      if (targetCurrency !== 'USD') {
        targetToUsd = 1 / this.rates[targetCurrency];
      }

      if (baseCurrency !== 'USD') {
        usdToBase = this.rates[baseCurrency];
      }

      const baseAmount = targetAmount * targetToUsd * usdToBase;
      this.firstCurrency!.Amount = parseFloat(baseAmount.toFixed(5));
      this.first?.patchValue(this.firstCurrency!);
    }
  }
}
