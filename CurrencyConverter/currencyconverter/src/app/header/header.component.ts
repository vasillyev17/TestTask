import { Component, OnInit } from '@angular/core';
import { NetworkingService } from '../networking.service';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit {
  usdToUah: number = 0;
  eurToUah: number = 0;

  constructor(private currencyService: NetworkingService) { }

  ngOnInit() {
    this.fetchRates();
  }

  fetchRates() {
    this.currencyService.getUsdRates().subscribe(data => {
      this.usdToUah = data.conversion_rates['UAH'];
      this.eurToUah = data.conversion_rates['EUR'] * this.usdToUah;
    });
  }
}
