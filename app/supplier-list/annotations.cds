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

            {   Label : 'Country',
                $Type : 'UI.DataField',
                Value : CountryCode,
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'ResilienceCockpitService.UpVote',
                Label : 'UpVote',
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'ResilienceCockpitService.DownVote',
                Label : 'DownVote',
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
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Supplier Parts',
            ID : 'SupplierParts',
            Target : 'SupplierParts/@UI.LineItem#SupplierParts',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Supplier Number',
            Value : SupplierNumber,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Supplier Name',
            Value : SupplierName,
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint#SupplierRating1',
            Label : 'SupplierRating',
        },
        {
            $Type : 'UI.DataField',
            Label : 'Address',
            Value : Address,
        },
        {
            $Type : 'UI.DataFieldForActionGroup',
            Actions : [
                {
                    $Type : 'UI.DataFieldForAction',
                    Action : 'ResilienceCockpitService.UpVote',
                    Label : 'UpVote',
                },
                {
                    $Type : 'UI.DataFieldForAction',
                    Action : 'ResilienceCockpitService.DownVote',
                    Label : 'DownVote',
                },
            ],
            ID : 'UpdateRating',
            Label : 'Update Rating',
        },
        {
            $Type : 'UI.DataField',
            Value : CountryCode,
        },
    ],
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : SupplierName,
        },
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : SupplierNumber,
        },
    },
    UI.DataPoint #SupplierRating : {
        Value : SupplierRating,
        Visualization : #Rating,
        TargetValue : 5,
    },
    UI.DataPoint #SupplierRating1 : {
        Value : SupplierRating,
        Visualization : #Rating,
        TargetValue : 5,
    },
);

annotate service.SupplierParts with @(
    UI.LineItem #SupplierParts : [
        {
            $Type : 'UI.DataField',
            Value : PartNumber,
            Label : 'PartNumber',
        },
        {
            $Type : 'UI.DataField',
            Value : Specifications_Dimensions_Height,
            Label : 'Specifications_Dimensions_Height',
        },
        {
            $Type : 'UI.DataField',
            Value : Specifications_Dimensions_Length,
            Label : 'Specifications_Dimensions_Length',
        },
        {
            $Type : 'UI.DataField',
            Value : Specifications_Dimensions_Width,
            Label : 'Specifications_Dimensions_Width',
        },
        {
            $Type : 'UI.DataField',
            Value : Specifications_Voltage,
            Label : 'Specifications_Voltage',
        },
        {
            $Type : 'UI.DataField',
            Value : LeadTime,
            Label : 'LeadTime',
        },
    ],
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Part Information',
            ID : 'PartInformation',
            Target : '@UI.FieldGroup#PartInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Alternatives for Original Material',
            ID : 'AlternativesforOriginalMaterial',
            Target : 'PossibleAlternates/@UI.LineItem#AlternativesforOriginalMaterial',
        },
    ],
    UI.FieldGroup #PartInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : LeadTime,
                Label : 'LeadTime',
            },
            {
                $Type : 'UI.DataField',
                Value : PartNumber,
                Label : 'PartNumber',
            },
            {
                $Type : 'UI.DataField',
                Value : Specifications_Dimensions_Height,
                Label : 'Specifications_Dimensions_Height',
            },
            {
                $Type : 'UI.DataField',
                Value : Specifications_Dimensions_Length,
                Label : 'Specifications_Dimensions_Length',
            },
            {
                $Type : 'UI.DataField',
                Value : Specifications_Dimensions_Width,
                Label : 'Specifications_Dimensions_Width',
            },
            {
                $Type : 'UI.DataField',
                Value : Specifications_Voltage,
                Label : 'Specifications_Voltage',
            },
        ],
    },
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : PartNumber,
        },
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : AlternateSupplier.SupplierNumber,
        },
    },
);

annotate service.AlternateSuppliers with {
    CountryCode @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'CommonCountries',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : CountryCode,
                    ValueListProperty : 'code',
                },
            ],
            Label : 'Select Country',
        },
        Common.ValueListWithFixedValues : false,
)};


annotate service.CommonCountries with {
    code @(
        Common.Text : name,
        Common.Text.@UI.TextArrangement : #TextFirst,
)};
annotate service.AlternateParts with @(
    UI.LineItem #AlternativesforOriginalMaterial : [
        {
            $Type : 'UI.DataField',
            Value : AlternatePart_ID,
            Label : 'AlternatePart_ID',
        },
        {
            $Type : 'UI.DataField',
            Value : OriginalPartNumber,
            Label : 'OriginalPartNumber',
        },
        {
            $Type : 'UI.DataField',
            Value : PercentageMatch,
            Label : 'PercentageMatch',
        },
    ]
);

annotate service.AlternateParts with {
    OriginalPartNumber @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'A_PurchasingInfoRecord',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : OriginalPartNumber,
                    ValueListProperty : 'Material',
                },
            ],
        },
        Common.ValueListWithFixedValues : false,
)};

annotate service.A_PurchasingInfoRecord with {
    Material @Common.Text : SupplierMaterialNumber
};

