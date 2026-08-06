using { ResilienceCockpit as my } from '../db/schema.cds';

@path : '/service/ResilienceCockpitService'
@(requires: 'authenitcated-user')
service ResilienceCockpitService

{
    @cds.redirection.target
    @odata.draft.enabled
    @odata.draft.bypass 
    entity AlternateSuppliers as
        projection on my.AlternateSuppliers
        {
            *,
            Country.name as CountryName,
            Country.code as CountryCode
        }
        excluding
        {
            Country
        };

    @cds.redirection.target
    @odata.draft.enabled
    entity AlternateParts as
        projection on my.AlternateParts;
}
