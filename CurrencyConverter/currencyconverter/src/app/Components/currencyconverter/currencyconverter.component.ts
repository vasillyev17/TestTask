import { Component, OnInit } from '@angular/core';
import { NetworkingService } from '../../Services/networking/networking.service';
import { CurrencyWrapperComponent } from '../currency-wrapper/currency-wrapper.component';
@Component({
  selector: 'app-currency-converter',
  templateUrl: './currencyconverter.component.html',
  styleUrls: ['./currencyconverter.component.css']
})
export class CurrencyConverterComponent implements OnInit {
  constructor(private currencyService: NetworkingService) { }

  ngOnInit() {
  }
}
