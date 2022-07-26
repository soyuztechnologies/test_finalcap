using { anubhav.db } from '../db/datamodel';
using { anubhav.db.CDSView } from '../db/CDSView';

// https://cap.cloud.sap/docs/node.js/authentication
service CatalogService @(path: 'CatalogService') 
    @(requires: 'authenticated-user'){
    @readonly
    entity BusinessPartnerSet as projection on db.master.businesspartner;
    entity ProductSet as projection on db.master.product;
    @Capabilities : { Updatable, Deletable, Insertable, Readable }
    entity AddressSet as projection on db.master.address;
    @(restrict:[
        {
            grant: ['READ'],
            to: 'Viewer',
            where: 'bankName = $user.BankName'
        },
        {
            grant: ['READ','WRITE'],
            to: 'Admin'
        }
    ]) 

    entity EmployeeSet as projection on db.master.employees;
    //entity PurchaseOrderSet as projection on db.transaction.purchaseorder;
    entity PurchaseOrderItems as projection on db.transaction.poitems;
    entity POs @(
        title: 'PurchaseOrder',
        odata.draft.enabled: true
    ) as projection on db.transaction.purchaseorder{
        *,
        case LIFECYCLE_STATUS
            when 'N' then 'New'
            when 'D' then 'Delivered'
            when 'B' then 'Blocked'
            end as LIFECYCLE_STATUS: String(20),
        case LIFECYCLE_STATUS
            when 'N' then 2
            when 'B' then 1
            when 'D' then 3
            end as Criticality: Integer,
        Items: redirected to PurchaseOrderItems
    }actions{
        function largestOrder() returns array of POs;
        action boost();
    };

    //entity POValues as projection on CDSView.CProductValuesView;
}