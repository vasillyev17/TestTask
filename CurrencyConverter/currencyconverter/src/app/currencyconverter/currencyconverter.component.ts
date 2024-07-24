import { Component, OnInit } from '@angular/core';
import { NetworkingService } from '../networking.service';

@Component({
  selector: 'app-currency-converter',
  templateUrl: './currencyconverter.component.html',
  styleUrls: ['./currencyconverter.component.css']
})
export class CurrencyconverterComponent implements OnInit {
  baseCurrency = 'USD';
  targetCurrency = 'EUR';
  baseAmount = 1;
  targetAmount = 1;
  currencies: string[] = [];
  rates: any = {};

  constructor(private currencyService: NetworkingService) { }

  ngOnInit() {
    this.fetchRates();
  }

  fetchRates() {
    this.currencyService.getUsdRates().subscribe(data => {
      this.rates = data.conversion_rates;
      this.currencies = Object.keys(this.rates);
      this.convertFromBase();
    });
  }

  convertFromBase() {
    if (this.rates && this.rates[this.targetCurrency]) {
      if (this.baseCurrency === 'USD') {
        this.targetAmount = parseFloat((this.baseAmount * this.rates[this.targetCurrency]).toFixed(5));
      } else {
        const baseToUsd = 1 / this.rates[this.baseCurrency];
        const usdToTarget = this.rates[this.targetCurrency];
        this.targetAmount = parseFloat((this.baseAmount * baseToUsd * usdToTarget).toFixed(5));
      }
    }
  }

  convertFromTarget() {
    if (this.rates && this.rates[this.targetCurrency]) {
      if (this.baseCurrency === 'USD') {
        this.baseAmount = parseFloat((this.targetAmount / this.rates[this.targetCurrency]).toFixed(5));
      } else {
        const targetToUsd = 1 / this.rates[this.targetCurrency];
        const usdToBase = this.rates[this.baseCurrency];
        this.baseAmount = parseFloat((this.targetAmount * targetToUsd * usdToBase).toFixed(5));
      }
    }
  }

  onBaseAmountChange() {
    this.convertFromBase();
  }

  onTargetAmountChange() {
    this.convertFromTarget();
  }

  onBaseCurrencyChange(event: Event) {
    const target = event.target as HTMLSelectElement;
    this.baseCurrency = target.value;
    this.convertFromBase();
  }

  onTargetCurrencyChange(event: Event) {
    const target = event.target as HTMLSelectElement;
    this.targetCurrency = target.value;
    this.convertFromBase();
  }
}
