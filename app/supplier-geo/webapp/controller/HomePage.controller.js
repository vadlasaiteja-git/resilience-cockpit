sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("nexus.suppliergeo.controller.HomePage", {
        onInit() {
            	// Messaging.registerObject(this.getView(), true);

			const oProvider = this.byId("mapProvider");
			const osm = sap.ui.require.toUrl("nexus/suppliergeo/model/osm.json");
			setTimeout(() => {
				oProvider.setStyleUrl(`${osm}`);
			});
        },

        onAfterRendering(){
             this.getView().getModel().read("/A_PurchasingInfoRecord", {
            success: (oData) => {
              console.log("Data fetched successfully:", oData);
            },
            error: (oError) => {
              console.error("Error fetching data:", oError);
            }
          });  
        },
        	spotClick: function(oEvent) {
            console.log("Spot clicked", oEvent);
			const oTarget = oEvent.getSource();
            const oData =  oTarget.getBindingContext().getObject();
            const sMessage = `You clicked on the Supplier with ID: ${oData.Supplier} and PurchasingInfoRecord: ${oData.PurchasingInfoRecord}`;
            sap.m.MessageToast.show(sMessage);

			// const oPopover = new Popover({
			// 	title: "Spot Info",
			// 	content: [
			// 		new List({
			// 			items: [
			// 				new StandardListItem({
			// 					title: `Latitude: ${oTarget.getLat()}`
			// 				}),
			// 				new StandardListItem({
			// 					title: `Longitude: ${oTarget.getLng()}`
			// 				})
			// 			]
			// 		})
			// 	]
			// });
			// oTarget.addDependent(oPopover);
			// oPopover.openBy(oTarget);
		}
    });
});