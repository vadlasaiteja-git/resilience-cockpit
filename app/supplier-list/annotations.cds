using ResilienceCockpitService as service from '../../srv/service';
annotate service.AlternateSuppliers with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'SupplierNumber',
                Value : SupplierNumber,
            },
            {
                $Type : 'UI.DataField',
                Label : 'SupplierName',
                Value : SupplierName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Address',
                Value : Address,
            },
            {
                $Type : 'UI.DataField',
                Label : 'SupplierRating',
                Value : SupplierRating,
            },
            {
                $Type : 'UI.DataField',
                Value : CountryName,
            },
            {
                $Type : 'UI.DataField',
                Value : CountryCode,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'SupplierNumber',
            Value : SupplierNumber,
        },
        {
            $Type : 'UI.DataField',
            Label : 'SupplierName',
            Value : SupplierName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Address',
            Value : Address,
        },
        {
            $Type : 'UI.DataField',
            Label : 'SupplierRating',
            Value : SupplierRating,
        },
        {
            $Type : 'UI.DataField',
            Value : CountryName,
        },
    ],
);

