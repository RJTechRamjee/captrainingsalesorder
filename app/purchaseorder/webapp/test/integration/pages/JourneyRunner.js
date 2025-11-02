sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"purchaseorder/test/integration/pages/PurchaseOrderServiceList",
	"purchaseorder/test/integration/pages/PurchaseOrderServiceObjectPage",
	"purchaseorder/test/integration/pages/PurcaseItemsServiceObjectPage"
], function (JourneyRunner, PurchaseOrderServiceList, PurchaseOrderServiceObjectPage, PurcaseItemsServiceObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('purchaseorder') + '/test/flp.html#app-preview',
        pages: {
			onThePurchaseOrderServiceList: PurchaseOrderServiceList,
			onThePurchaseOrderServiceObjectPage: PurchaseOrderServiceObjectPage,
			onThePurcaseItemsServiceObjectPage: PurcaseItemsServiceObjectPage
        },
        async: true
    });

    return runner;
});

