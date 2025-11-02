using CatalogService as service from '../../srv/cat-service';


annotate service.PurchaseOrderService with @(
    UI.SelectionFields : [
        PO_ID,
        GROSS_AMOUNT,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.BP_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.discountOnPrice',
            Label : 'Discount',
            Inline : true
        },
        {
            $Type : 'UI.DataField',
            Value : LifecycleStatus,
            Criticality : LSC,
           
        },
        {
            $Type : 'UI.DataField',
            Value : OverallStatus,
            Criticality : OSC,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        }
    ],
    UI.HeaderInfo : {
        TypeName : 'Purchase Order',
        TypeNamePlural : 'Purchase Orders',
        Title : {
            Label : 'Purchase Order ID',
            Value : PO_ID
        },
        Description : {
            Label : 'Company Name',
            Value : PARTNER_GUID.COMPANY_NAME
        },
        ImageUrl : 'https://www.liblogo.com/img-logo/sa2839sc40-sap-logo-sap-sap-market-capitalization.png'
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Purchase Order Details',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'More details about Purchase Header',
                    Target : '@UI.FieldGroup#MoreInfo'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Amount details of Purchase Order',
                    Target : '@UI.FieldGroup#PriceInfo'
                }
            ]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Purchase Items Information',
            Target : 'Items/@UI.LineItem'
        }
    ],
    UI.FieldGroup #MoreInfo : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PO_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID_NODE_KEY,
            },
            {
                $Type : 'UI.DataField',
                Value : LifecycleStatus,
                Criticality : LSC,
            },
            {
                $Type : 'UI.DataField',
                Value : OverallStatus,
                Criticality : OSC,
            }
        ]
    },
    UI.FieldGroup #PriceInfo : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            }
        ]
    }
);


annotate service.PurcaseItemsService with @(
 UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : PO_ITEMS_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        }
    ],
    UI.HeaderInfo : {
        TypeName : 'Purchase Item',
        TypeNamePlural : 'Purchase Items',
        Title : {
            $Type : 'UI.DataField',
            Value : PO_ITEMS_POS
        },
        Description : {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.DESCRIPTION
        },
        ImageUrl : 'https://www.liblogo.com/img-logo/sa2839sc40-sap-logo-sap-sap-market-capitalization.png'
    },
 UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Purchase Items Details',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Price information of Purhcase Items',
                    Target : '@UI.FieldGroup#PriceDetails'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Product Information of Purchase Items',
                    Target : '@UI.FieldGroup#ProductDetails'
                }
            ]
        }
    ],
 UI.FieldGroup #PriceDetails: {
    Data : [
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code
        }
    ]
 },
  UI.FieldGroup #ProductDetails: {
    Data : [
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.PRODUCT_ID
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.DESCRIPTION
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.CATEGORY
        },
        {
            $Type : 'UI.DataField',
            Value :  PRODUCT_GUID.PRICE
        },
        {
            $Type : 'UI.DataField',
            Value :  PRODUCT_GUID.DIM_UNIT
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.WEIGHT_UNIT
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.WEIGHT_MEASURE
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.HEIGHT
        },
        {
            $Type : 'UI.DataField',
            Value :  PRODUCT_GUID.DEPTH
        },
        {
            $Type : 'UI.DataField',
            Value :  PRODUCT_GUID.WIDTH
        }
    ]
 }
) ;
