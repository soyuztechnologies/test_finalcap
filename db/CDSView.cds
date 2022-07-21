namespace anubhav.db;

using
{
    anubhav.db.master,
    anubhav.db.transaction
}
from './datamodel';

using
{
    anubhav.common
}
from './common';

context CDSView
{
    entity POWorklist
    {
        key PurchaseOrderId : String(24);
        key ItemPosition : Integer;
        PartnerId : String(32)
            @title : '{i18n>bp_id}';
        CompanyName : String(250)
            @title : '{i18n>company_name}';
        City : String(44);
        Country : String(44);
        POGrossAmount : common.AmountT;
        POCurrencyCode : String(4);
        Status : String(1);
        ProductId : String(28);
        ProductName : localized String(255);
        GrossAmount : common.AmountT;
        NetAmount : common.AmountT;
        TaxAmount : common.AmountT;
        CurrencyCode : String(4);
    }

    entity ProductValueHelp as
        select from master.product
        {
                @EndUserText.label : [
            {
                language : 'EN',
                text : 'Product ID'
            }
            ,
            {
                language : 'DE',
                text : 'Prodekt ID'
            }
            ] PRODUCT_ID as ![ProductId],
                @EndUserText.label : [
            {
                language : 'EN',
                text : 'Product Description'
            }
            ,
            {
                language : 'DE',
                text : 'Prodekt Description'
            }
            ] DESCRIPTION as ![Description]
        };

    entity ItemView
    {
        Partner : db.Guid
            @title : '{i18n>bp_key}';
        ProductId : db.Guid;
        CurrencyCode : String(4);
        GrossAmount : common.AmountT;
        NetAmount : common.AmountT;
        TaxAmount : common.AmountT;
        POStatus : String(1);
    }

    entity ProductViewSub as
        select from master.product as prod
        {
            PRODUCT_ID as ![ProductId],
            texts.DESCRIPTION as ![Description],
            (select from transaction.poitems as a
                {
                    SUM(a.GROSS_AMOUNT) as SUM
                }
                where a.PRODUCT_GUID.NODE_KEY = prod.NODE_KEY) as PO_SUM
        };

    entity ProductView as
        select from master.product mixin
        {
            PO_ORDERS : Association [*] to ItemView
                on PO_ORDERS.ProductId =$projection.ProductId
        }
        into
        {
            NODE_KEY as ![ProductId],
            DESCRIPTION,
            CATEGORY as ![Category],
            PRICE as ![Price],
            TYPE_CODE as ![TypeCode],
            SUPPLIER_GUID.BP_ID as ![BPId],
            SUPPLIER_GUID.COMPANY_NAME as ![CompanyName],
            SUPPLIER_GUID.ADDRESS_GUID.CITY as ![City],
            SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as ![Country],
            PO_ORDERS
        };

    entity CProductValuesView as
        select from ProductView
        {
            ProductId,
            Country,
            PO_ORDERS.CurrencyCode as ![CurrencyCode],
            round(sum(PO_ORDERS.GrossAmount),
                2) as ![POGrossAmount] : Decimal(15,
                2)
        }
        group by ProductId, Country, PO_ORDERS.CurrencyCode;
}
