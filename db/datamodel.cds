// <Company name>.<Module Name>.<Application Name>
namespace salesorders.db;


using { salesorders.common as common } from './common' ;
using { cuid,
        Currency
        } from '@sap/cds/common';


context master {
    entity businesspartner {
        key NODE_KEY : common.Guid @(title : '{i18n>NODE_KEY}');
            BP_ROLE : String(2) @(title : '{i18n>BP_ROLE}');
            EMAIL : common.Email @(title : '{i18n>EMAIL}');
            MOBILE : common.PhoneNumber @(title : '{i18n>MOBILE}');
            FAX : String(32) @(title : '{i18n>FAX}');
            WEB: String(255) @(title : '{i18n>WEB}');
            BP_ID : common.Guid @(title : '{i18n>BP_ID}');
            COMPANY_NAME : String(255) @(title : '{i18n>COMPANY_NAME}');
            ADDRESS_GUID : Association to address @(title : '{i18n>ADDRESS_GUID}');
    }


    entity address : common.Address {
        key NODE_KEY : common.Guid @(title : '{i18n>NODE_KEY}');
            ADDRESS_TYPE : String(44) @(title : '{i18n>ADDRESS_TYPE}');
            VAL_START : Date @(title : '{i18n>VAL_START}');
            VAL_END : Date @(title : '{i18n>VAL_END}');
            LATITUDE : Decimal @(title : '{i18n>LATITUDE}');
            LONGITUDE : Decimal @(title : '{i18n>LONGITUDE}');
            // Unmanaged Association
            businesspartner : Association to one businesspartner
                                    on businesspartner.ADDRESS_GUID = $self;


    }


    entity product {
        key NODE_KEY : common.Guid @(title : '{i18n>NODE_KEY}');
            PRODUCT_ID : String(28) @(title : '{i18n>PRODUCT_ID}');
            TYPE_CODE : String(2) @(title : '{i18n>TYPE_CODE}');
            CATEGORY : String(32) @(title : '{i18n>CATEGORY}');
            DESCRIPTION : String(255) @(title : '{i18n>DESCRIPTION}');
            TAX_TARIF_CODE : Integer @(title : '{i18n>TAX_TARIF_CODE}');
            MEASURE_UNIT : String(2) @(title : '{i18n>MEASURE_UNIT}');
            WEIGHT_MEASURE : Decimal(5,2) @(title : '{i18n>WEIGHT_MEASURE}');
            WEIGHT_UNIT : String(2) @(title : '{i18n>WEIGHT_UNIT}');
            CURRENCY_CODE : String(4) @(title : '{i18n>CURRENCY_CODE}');
            PRICE : Decimal(15,2) @(title : '{i18n>PRICE}');
            WIDTH : Decimal(5,2) @(title : '{i18n>WIDTH}');
            HEIGHT : Decimal(5,2) @(title : '{i18n>HEIGHT}');
            DEPTH : Decimal(5,2) @(title : '{i18n>DEPTH}');
            DIM_UNIT : String(2) @(title : '{i18n>DIM_UNIT}');
            // Managed Association
            SUPPLIER_GUID : Association to businesspartner @(title : '{i18n>SUPPLIER_GUID}');
    }


    entity emplyees : cuid {
        nameFirst : String(40);
        nameLast : String(40);
        nameInitials : String(40);
        nameMiddle : String(40);
        gender : common.Gender;
        language : String(2);
        phoneNumber : common.PhoneNumber;
        email : common.Email;
        loginName : String(16);
        Currency : Currency;
        salaryAmount : common.AmountT;
        accountNumber : String(16);
        bankId : String(16);
        bankName : String(64);
    }
}


context transaction {
    entity salesorder : common.Amount {
        key NODE_KEY : common.Guid @(title : '{i18n>NODE_KEY}');
        PO_ID : String(40) @(title : '{i18n>PO_ID}');
        PARTNER_GUID : Association to master.businesspartner @(title : '{i18n>PARTNER_GUID}');
        LIFECYCLE_STATUS : String(1) @(title : '{i18n>LIFECYCLE_STATUS}');
        OVERALL_STATUS : String(1) @(title : '{i18n>OVERALL_STATUS}');
        Items : Composition of many salesorderitems
                    on Items.PARENT_KEY = $self;
    }


    entity salesorderitems : common.Amount{
        key NODE_KEY : common.Guid @(title : '{i18n>NODE_KEY}');
        PARENT_KEY : Association to salesorder @(title : '{i18n>PARENT_KEY}');
        PO_ITEMS_POS : Integer @(title : '{i18n>PO_ITEMS_POS}');
        PRODUCT_GUID : Association to master.product @(title : '{i18n>PRODUCT_GUID}');
    }
}
