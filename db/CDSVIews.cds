namespace salesorders.cdsviews;
using { salesorders.db.master, salesorders.db.transaction  } from './datamodel';




context CDSViews {
    define view ![POWorklist] as
        select from transaction.salesorder {
            key PO_ID as ![PurchaseOrderID],
            key Items.PO_ITEMS_POS as ![JItemPosition],
            PARTNER_GUID.BP_ID as ![PartnerID],
            PARTNER_GUID.COMPANY_NAME as ![CompanyName],
            GROSS_AMOUNT as ![GrossAmount],
            NET_AMOUNT as ![NetAmount],
            TAX_AMOUNT as ![TaxAmount],
            CURRENCY as ![CurrencyCode],
            OVERALL_STATUS as ![OverallStatus],
            Items.PRODUCT_GUID.PRODUCT_ID as ![ProductID],
            Items.PRODUCT_GUID.DESCRIPTION as ![ProductDescription],
            PARTNER_GUID.ADDRESS_GUID.CITY as ![City],
            PARTNER_GUID.ADDRESS_GUID.COUNTRY as ![Country]
        };


    define view ![ItemView] as  
        select from transaction.salesorderitems {
            PARENT_KEY.PARTNER_GUID.NODE_KEY as ![CustomerID],
            PRODUCT_GUID.NODE_KEY as ![ProductID],
            CURRENCY as ![Currency],
            GROSS_AMOUNT as ![GrossAmount],
            NET_AMOUNT as ![NetAmount],
            TAX_AMOUNT as ![TaxAmount],
            PARENT_KEY.OVERALL_STATUS as ![Status]
        };
   
    define view ProductView as select from master.product
        mixin {
            PO_ORDER : Association[*] to ItemView on PO_ORDER.ProductID = $projection.ProductID
        } into {
            NODE_KEY as ![ProductID],
            DESCRIPTION as ![Description],
            CATEGORY as ![Category],
            PRICE as ![Price],
            SUPPLIER_GUID.BP_ID as ![SupplierID],
            SUPPLIER_GUID.COMPANY_NAME as ![SupplierName],
            SUPPLIER_GUID.ADDRESS_GUID.CITY as ![City],
            SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as ![Country],
            PO_ORDER as ![ToItems]
        }
}
