export class Currency {
    private _currency: string;
    private _amount: number;

    constructor(currency?: string, amount?: number) {
        this._currency = currency || 'USD';
        this._amount = amount || 0;
    }

    get Currency(): string {
        return this._currency;
    }

    set Currency(currency: string) {
        this._currency = currency;
    }

    get Amount(): number {
        return this._amount;
    }

    set Amount(amount: number) {
        this._amount = amount;
    }
}