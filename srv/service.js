const UPDATE = require("@sap/cds/lib/ql/UPDATE");

let impl = async function(srv321)
{
 // Simple Event Handler
 srv321
    .before("READ","AlternateSuppliers",function(req)
    {
        console.log("Read Triggered!");
    })

// Modifying Supplier Name
let injectSupplierRating = function(data, req)
{   
    let startOfDay = new Date();
    startOfDay.setHours(0,0,0,0);
    
    for (let i = 0; i < data.length; i++) 
    {
//Converting the Ratings to the base 10
//    data[i].SupplierRating /= 10;
//If Rating > 5 , Append Highly Rated to the Supplier Name
    if (data[i].SupplierRating >= 4) 
        {
          data[i].SupplierName += " - Highly Rated";
        } 
//If modified within 24 hrs, Add Recently Updated. 
    if (new Date(data[i].modifiedAt) >= startOfDay) 
        {
          data[i].SupplierName += " - Recently Updated";
        } 
    console.log(data[i]);

    }
}
 srv321
    .after("READ","AlternateSuppliers", injectSupplierRating) 

// Validating the Country Code before Updates or Creations

 async function countryCodeValidation(req)
{
    if (req.data?.CountryCode)
    {
        let countryCode = req.data.CountryCode;
        let country = await SELECT.one.from("sap.common.Countries")
                                      .where({code:countryCode});
            if(!country){
            return req.error(400, 'Country not found');
            }        
    }
}   
//srv321.before("UPDATE","AlternateSuppliers",countryCodeValidation  )

//srv321.before("CREATE", "AlternateSuppliers",countryCodeValidation)

// Instead of using in UPDATE and CREATE seperately, we can use this validation on "WRITE" operation

srv321.before("WRITE", "AlternateSuppliers",countryCodeValidation)


//Function to Return the Number of Supplier Parts associated with a Supplier
srv321.on("SupplierItemCount", "AlternateSuppliers",async function(req)
{
    let supplierID = req.params[0].ID
    let supplierParts = await SELECT("ID").from("ResilienceCockpit.SupplierParts").where({AlternateSupplier_ID:supplierID});
    return supplierParts.length;
})

//Action to Upvote a Supplier

srv321.on("UpVote","AlternateSuppliers",async function (req) 
{ 
    let supplierID = req.params[0].ID
    let supplierObject = await SELECT.one.from("ResilienceCockpit.AlternateSuppliers").where({ID:supplierID});
    supplierObject.SupplierRating += 1;

    await UPDATE("ResilienceCockpit.AlternateSuppliers").set({SupplierRating:supplierObject.SupplierRating}).where({ID:supplierID});
    req.notify("RatingUpdated");
    return supplierObject;
    
})

//Action to DownVote a Supplier

srv321.on("DownVote","AlternateSuppliers",async function (req) 
{ 
    let supplierID = req.params[0].ID
    let supplierObject = await SELECT.one.from("ResilienceCockpit.AlternateSuppliers").where({ID:supplierID});
    supplierObject.SupplierRating -= 1;

    await UPDATE("ResilienceCockpit.AlternateSuppliers").set({SupplierRating:supplierObject.SupplierRating}).where({ID:supplierID});
    req.notify("RatingUpdated");
    return supplierObject;
    
})


//Draft Event on NEW

srv321.after("NEW","AlternateSuppliers.drafts", async function(req) {
    console.log("New Draft Entry is Created")
})


//Connecting S4HANA API
let S4API = await cds.connect.to("API_INFORECORD_PROCESS_SRV");

srv321.on("READ","A_PurchasingInfoRecord", async function(req)
    {
               // Sanitize Request
        req.query.SELECT.columns.push({ref:['Supplier']});


        return S4API.read(req.query)
        .then(async data => {
            // Construct Data
            if(data.constructor === Array){
                return Promise.all(data.map(async record => {
                    let supplier = await SELECT.one
                        .from("ResilienceCockpit.SupplierLocations")
                        .where({ Supplier: record.Supplier });
                    if (supplier) {
                        record.Lat = supplier.Lat;
                        record.Lng = supplier.Lng;
                    }
                    return record;
                }))
            } else if(data.Supplier) {
                let supplier = await SELECT.one
                        .from("ResilienceCockpit.SupplierLocations")
                        .where({ Supplier: data.Supplier });
                if (supplier) {
                    data.Lat = supplier.Lat;
                    data.Lng = supplier.Lng;
                }
                return data;
            } else {
                return data;
            }

        });
    })
};


module.exports = impl;