import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class NetworkingService {
  private apiKey = 'b430e6f08e520c697ab637fa';
  private apiUrl = `https://v6.exchangerate-api.com/v6/${this.apiKey}/latest/USD`;

  constructor(private http: HttpClient) { }

  getUsdRates(): Observable<any> {
    return this.http.get(this.apiUrl);
  }
}

