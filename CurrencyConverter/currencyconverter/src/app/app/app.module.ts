import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';
import { ReactiveFormsModule } from '@angular/forms';

import { AppComponent } from './app.component';
import { CurrencyConverterComponent } from '../Components/currencyconverter/currencyconverter.component';
import { HeaderComponent } from '../Components/header/header.component';
import { InputDataComponent } from '../Components/inputdata/inputdata.component';
import { CurrencyWrapperComponent } from '../Components/currency-wrapper/currency-wrapper.component';

@NgModule({
  declarations: [
    AppComponent,
    CurrencyConverterComponent,
    HeaderComponent,
    InputDataComponent,
    CurrencyWrapperComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    ReactiveFormsModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
