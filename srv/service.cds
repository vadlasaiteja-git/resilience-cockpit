using { ResilienceCockpit as my } from '../db/schema.cds';

@path : '/service/ResilienceCockpitService'
service ResilienceCockpitService
{
    @cds.redirection.target
    @odata.draft.enabled
    entity AlternateSuppliers as
        projection on my.AlternateSuppliers
        {
            *,
            Country.descr,
            Country.name,
            Country.code
        };

    @cds.redirection.target
    @odata.draft.enabled
    entity AlternateParts as
        projection on my.AlternateParts;
}
