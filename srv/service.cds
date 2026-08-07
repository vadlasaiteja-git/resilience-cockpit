using { ResilienceCockpit as my } from '../db/schema.cds';

@path : '/service/ResilienceCockpitService'
service ResilienceCockpitService
{
    @cds.redirection.target
    @odata.draft.bypass
    @odata.draft.enabled
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
        }
        actions
        {
            function SupplierItemCount
            (
            )
            returns Integer;

            action UpVote
            (
            )returns AlternateSuppliers ;
        };

    @cds.redirection.target
    @odata.draft.enabled
    entity AlternateParts as
        projection on my.AlternateParts;
}

annotate ResilienceCockpitService with @requires :
[
    'authenitcated-user'
];
