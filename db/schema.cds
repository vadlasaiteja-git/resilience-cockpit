namespace ResilienceCockpit;

using from '@sap/cds-common-content';

using
{
    cuid,
    managed,
    Country
}
from '@sap/cds/common';

entity AlternateSuppliers : cuid, managed
{
    SupplierNumber : String(100);
    SupplierName : String(100);
    Address : String(500);
    Country : Country;
    SupplierRating : Integer;
    SupplierParts : Composition of many SupplierParts on SupplierParts.AlternateSupplier = $self;
}

entity SupplierParts : cuid, managed
{
    PartNumber : Integer;
    LeadTime : Integer;
    Specifications : SpecificationType;
    AlternateSupplier : Association to one AlternateSuppliers;
    PossibleAlternates : Association to many AlternateParts on PossibleAlternates.AlternatePart = $self;
}

type SpecificationType
{
    Voltage : Decimal(5,2);
    Dimensions : Dimensiontype;
}

type Dimensiontype
{
    Length : Decimal(5,2);
    Width : Decimal(5,2);
    Height : Decimal(5,2);
}

entity AlternateParts : cuid
{
    OriginalPartNumber : String(30);
    PercentageMatch : Integer;
    AlternatePart : Association to one SupplierParts;
}

entity SupplierLocations{
    key Supplier : String(32);
    Lat : Decimal(10, 8);
    Lng : Decimal(10,8);
    
}