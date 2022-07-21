using { anubhav.db } from '../db/datamodel';
using { anubhav.db.CDSView } from '../db/CDSView';

service CatalogService @(path: 'CatalogService') {
    entity BusinessPartnerSet as projection on db.master.businesspartner;
    //entity ProductSet as projection on db.master.product;
    entity AddressSet as projection on db.master.address;
    entity EmployeeSet as projection on db.master.employees;
    //entity PurchaseOrderSet as projection on db.transaction.purchaseorder;
    entity PurchaseOrderItems as projection on db.transaction.poitems;
    entity POs as projection on db.transaction.purchaseorder{
        *,
        Items: redirected to PurchaseOrderItems
    };

    entity POValues as projection on CDSView.CProductValuesView;
}