namespace salesorders.common;


// Standard Reusable Types
using { Currency } from '@sap/cds/common';




// Reusable Types
type Guid        : String(32);
type PhoneNumber : String(64);
type Email       : String(255);


// Enumerator
type Gender      : String(1) enum {
    male = 'M';
    female = 'F';
    undisclosed = 'U';
}


// Reusable Type for Amount
type AmountT     : Decimal(10, 2) @(
    Semantics.amount.currencyCode: 'CURRENCY_CODE',
    sap.unit                     : 'CURRENCY_CODE'
);


// Reusable Aspect - Group of fields( Structure )
aspect Amount : {
    CURRENCY     : Currency @(title : '{i18n>CURRENCY_CODE}');
    GROSS_AMOUNT : AmountT @(title : '{i18n>GROSS_AMOUNT}');
    NET_AMOUNT   : AmountT @(title : '{i18n>NET_AMOUNT}');
    TAX_AMOUNT   : AmountT @(title : '{i18n>TAX_AMOUNT}');
}


aspect Address {
    STREET   : String(64)  @(title : '{i18n>STREET}');
    POSTAL : String(12)  @(title : '{i18n>POSTAL}');
    CITY     : String(64)  @(title : '{i18n>CITY}');
    COUNTRY  : String(64)  @(title : '{i18n>COUNTRY}');
    BUILDING : String(255)  @(title : '{i18n>BUILDING}');
}

