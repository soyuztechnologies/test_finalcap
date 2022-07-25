using CatalogService as service from '../../srv/CatalogService';

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

        ]
    }
);

