using CatalogService as service from '../../srv/CatalogService';

annotate CatalogService.POs with {
    PARTNER_GUID @(
        Common.Text: PARTNER_GUID.COMPANY_NAME,
        Common.ValueList.entity : CatalogService.BusinessPartnerSet
    )
};

@cds.odata.valuelist
annotate CatalogService.BusinessPartnerSet with @(
    UI.Identification :[
        {
            $Type : 'UI.DataField',
            Value : COMPANY_NAME,
        },
        {
            $Type : 'UI.DataField',
            Value : EMAIL_ADDRESS,
        },
        {
            $Type : 'UI.DataField',
            Value : PHONE_NUMBER,
        },
    ]

);

annotate CatalogService.PurchaseOrderItems with {
    PRODUCT_GUID @(
        Common.Text: PRODUCT_GUID.DESCRIPTION,
        Common.ValueList.entity : CatalogService.ProductSet
    )
};

@cds.odata.valuelist
annotate CatalogService.ProductSet with @(
    UI.Identification :[
        {
            $Type : 'UI.DataField',
            Value : DESCRIPTION,
        },
        {
            $Type : 'UI.DataField',
            Value : PRICE,
        },
        {
            $Type : 'UI.DataField',
            Value : TYPE_CODE,
        },
    ]

);


annotate CatalogService.POs with @(

    UI: {
        SelectionFields: [
            PO_ID,
            GROSS_AMOUNT,
            LIFECYCLE_STATUS,
            CURRENCY_CODE
        ],
        LineItem: [
            {
             $Type: 'UI.DataField',
             Value: PO_ID
            },
            {
             $Type: 'UI.DataField',
             Value: GROSS_AMOUNT
            },
            {
             $Type: 'UI.DataFieldForAction',
             Label: 'Boost',
             Action: 'CatalogService.boost',
             Inline: true
            },
            {
             $Type: 'UI.DataField',
             Value: CURRENCY_CODE
            },
            {
             $Type: 'UI.DataField',
             Value: PARTNER_GUID.COMPANY_NAME
            },
            {
             $Type: 'UI.DataField',
             Value: PARTNER_GUID.COMPANY_NAME
            },
            {
             $Type: 'UI.DataField',
             Value: LIFECYCLE_STATUS,
             Criticality: Criticality,
             CriticalityRepresentation : #WithIcon
            },
            {
             $Type: 'UI.DataField',
             Value: TAX_AMOUNT
            }

        ],
        HeaderInfo :{
            $Type: 'UI.HeaderInfoType',
            TypeName: '{i18n>poHeader}',
            TypeNamePlural: '{i18n>poHeader}',
            Title: {
                Label: '{i18n>PO_ID}',
                Value: PO_ID
            },
            Description: {
                Label: '{i18n>Node_KEy}',
                Value: PARTNER_GUID.COMPANY_NAME
            },
            ImageUrl: 'https://yt3.ggpht.com/JGjuwG8rh2KcpqGZ6kobPU68IUQcsXLLmouF-VFj7li2M178ve5uHub5qfNJCpKdrHbLGcch3Q=s900-c-k-c0x00ffffff-no-rj'
        },
        Facets: [{
            $Type: 'UI.ReferenceFacet',
            Label: 'Header Info',
            Target: ![@UI.FieldGroup#Anubhav]
        },{
            $Type: 'UI.ReferenceFacet',
            Label: 'PO Items',
            Target: 'Items/@UI.LineItem'
        }
        ],
        FieldGroup#Anubhav :{
            $Type: 'UI.FieldGroupType',
            Data: [
                {
                $Type: 'UI.DataField',
                Value: PO_ID
                },
                {
                $Type: 'UI.DataField',
                Value: PARTNER_GUID_NODE_KEY
                },
                {
                $Type: 'UI.DataField',
                Value: PARTNER_GUID.COMPANY_NAME
                },
                {
                $Type: 'UI.DataField',
                Value: PARTNER_GUID.BP_ID
                },
                {
                $Type: 'UI.DataField',
                Value: GROSS_AMOUNT
                },
                {
                $Type: 'UI.DataField',
                Value: NET_AMOUNT
                },
                {
                $Type: 'UI.DataField',
                Value: TAX_AMOUNT
                },
                {
                $Type: 'UI.DataField',
                Value: LIFECYCLE_STATUS
                },
                {
                $Type: 'UI.DataField',
                Value: CURRENCY_CODE
                }
            ]
        }
    
    }

);


annotate CatalogService.PurchaseOrderItems with @(
    UI: {
        LineItem: [
            {
             $Type: 'UI.DataField',
             Value: PO_ITEM_POS
            },
            {
             $Type: 'UI.DataField',
             Value: PRODUCT_GUID_NODE_KEY
            },
            {
             $Type: 'UI.DataField',
             Value: PRODUCT_GUID.PRODUCT_ID
            },
            {
             $Type: 'UI.DataField',
             Value: GROSS_AMOUNT
            },
            {
             $Type: 'UI.DataField',
             Value: NET_AMOUNT
            },
            {
             $Type: 'UI.DataField',
             Value: TAX_AMOUNT
            },
            {
             $Type: 'UI.DataField',
             Value: CURRENCY_CODE
            }

        ],
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'PO Item',
            TypeNamePlural : 'PO Items',
            Title: {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS
            },
            Description: {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.PRODUCT_ID,
            }           
        },
        Facets  : [
            {
                $Type : 'UI.ReferenceFacet',
                Label: 'Line Item Details',
                Target : '@UI.FieldGroup#ItemData',
            },
            {
                $Type : 'UI.ReferenceFacet',
                Label: 'Product Details',
                Target : '@UI.FieldGroup#ProductInfo',
            },
        ],
        FieldGroup#ItemData  : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {
                    $Type : 'UI.DataField',
                    Value : PO_ITEM_POS,
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
                    Value : CURRENCY_CODE,
                },
            ],
        },
        FieldGroup#ProductInfo  : {
            $Type : 'UI.FieldGroupType',
            Data : [
                {
                    $Type : 'UI.DataField',
                    Value : PRODUCT_GUID.PRODUCT_ID,
                },
                {
                    $Type : 'UI.DataField',
                    Value : PRODUCT_GUID.CATEGORY,
                },
                {
                    $Type : 'UI.DataField',
                    Value : PRODUCT_GUID.DESCRIPTION,
                },
                {
                    $Type : 'UI.DataField',
                    Value : PRODUCT_GUID.TYPE_CODE,
                },
                {
                    $Type : 'UI.DataField',
                    Value : PRODUCT_GUID.SUPPLIER_GUID.COMPANY_NAME,
                },
                {
                    $Type : 'UI.DataField',
                    Value : PRODUCT_GUID.PRICE,
                }
                
            ],
        },
    }
);

