using { salesorders.db as db  } from '../db/datamodel';


service CatalogService @(path: 'CatalogService') {


   entity BusinessPartnerService as projection on db.master.businesspartner;


   entity AddressService 
   // @( restrict : [
   //    {
   //       grant : ['READ'],
   //       to : 'myCountry',
   //       where : 'COUNTRY = $user.att.myCountry'
   //    },
   //    {
   //       grant : ['WRITE'],
   //       to : 'Admin'
   //    }
   // ]

   // ) 
   as projection on db.master.address;


   entity EmployeeService as projection on db.master.emplyees;


   entity ProductService as projection on db.master.product;


   entity PurcaseItemsService as projection on db.transaction.salesorderitems;


@odata.draft.enabled : true
   entity PurchaseOrderService as projection on db.transaction.salesorder{
      *,
               case OVERALL_STATUS
            when 'N' then 'New'
            when 'P' then 'Pending'
            when 'B' then 'Blocked'
            when 'R' then 'Returned'
            else 'Delivered'
         end as OverallStatus : String(20) @(title : '{i18n>OVERALL_STATUS_T}'),
         case OVERALL_STATUS
            when 'N' then 3
            when 'P' then 2
            when 'B' then 1
            when 'R' then 2
            else 3
         end as OSC : Integer,
         case LIFECYCLE_STATUS
            when 'N' then 'Not Paid'
            when 'P' then 'Paid'
            when 'C' then 'Completed'
            else 'Cancelled'
         end as LifecycleStatus : String(20) @(title : '{i18n>LIFECYCLE_STATUS_T}'),
         case LIFECYCLE_STATUS
            when 'N' then 1
            when 'P' then 2
            when 'C' then 3
            else 1
         end as LSC : Integer,
      Items: redirected to PurcaseItemsService
   } actions {
      @cds.odata.bindingparameter.name : 'ABC'
      @Common.SideEffects : {
         TargetProperties : ['ABC/GROSS_AMOUNT']
      }
      action discountOnPrice() returns PurchaseOrderService;
      function smallestOrder() returns array of PurchaseOrderService;
      function largestOrder() returns array of PurchaseOrderService;
   };


   action createEmployee(Currency_code: String,
                         ID: UUID,
                         accountNumber: String,
                         bankId: String,
                         bankName: String,
                         email: String,
                         gender: String,
                         language: String,
                         loginName: String,
                         nameFirst: String,
                         nameInitials: String,
                         nameLast: String,
                         nameMiddle: String,
                         phoneNumber: String,
                         salaryAmount: String, ) returns array of EmployeeService;

}

