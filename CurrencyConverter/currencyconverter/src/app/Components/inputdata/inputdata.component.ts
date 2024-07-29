import { Component, EventEmitter, Input, OnDestroy, OnInit, Output } from '@angular/core';
import { FormGroup, FormControl } from '@angular/forms';
import { Subject, takeUntil, tap } from 'rxjs';
import { Currency } from 'src/app/models/currency';

@Component({
  selector: 'app-currency-input',
  templateUrl: './inputdata.component.html',
  styleUrls: ['./inputdata.component.css'],
})
export class InputDataComponent implements OnInit, OnDestroy {
  @Input() currencies: string[] = [];
  @Output() valuesChanged = new EventEmitter<Currency>();

  public formGroup: FormGroup = new FormGroup({
    amount: new FormControl(),
    currency: new FormControl()
  });
  private _takeUntil$ = new Subject<boolean>();

  ngOnInit(): void {
    this.patchValue(new Currency());

    this.formGroup.valueChanges
      .pipe(
        takeUntil(this._takeUntil$),
        tap((value) => {
          this.valuesChanged.emit(new Currency(value.currency, value.amount));
        }),
      ).subscribe();
  }

  ngOnDestroy(): void {
    this._takeUntil$.next(true);
    this._takeUntil$.complete();
  }

  patchValue(value: Currency): void {
    this.formGroup.setValue({
      amount: value?.Amount,
      currency: value?.Currency
    }, { emitEvent: false });
  }

  getValue() {
    return new Currency(this.formGroup.value.currency, this.formGroup.value.amount);
  }
}
