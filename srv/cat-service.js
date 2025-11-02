const { request } = require("http");

module.exports = cds.service.impl(async function () {
    // Step-1 : Get the object from our OData Entities

    const { EmployeeService , PurchaseOrderService } = this.entities;

    // Step-2 Define generic handler for the pre-checks

    this.before('UPDATE', EmployeeService, (request, response) => {
        console.log(request.data.salaryAmount);
        if (parseFloat(request.data.salaryAmount) >= 100000) {
            request.error(500, "Please get approval from your line manager");
        }
    })
    this.before('CREATE', EmployeeService, (request, response) => {
        console.log(request.data.salaryAmount);
        if (parseFloat(request.data.salaryAmount) >= 100000) {
            request.error(500, "Please get approval from your line manager");
        }
    })
    this.on('createEmployee', async (request, response) => {
        const dataset = request.data;
        let returninfo = await cds.tx(request).run([
            INSERT.into(EmployeeService).entries(dataset)
        ]).then((resolve, reject) => {
            if (typeof (resolve) != undefined) {
                return request.data;
            } else {
                request.error(500, "Error in the creation of employee");
            }
        }).catch(err => {
            request.error(500, "There is an error " + err.toString());
        })
        return returninfo;
    })

    this.on('discountOnPrice', async(request,response) => {
        try {
            // get the parameters
            const ID = request.params[0];
            //const { discount } = request.data;

            const tx = cds.tx(request);

            await tx.update(PurchaseOrderService).with({
                GROSS_AMOUNT : {'-=' : 1000},
                NET_AMOUNT : {'-=' : 100},
                TAX_AMOUNT : {'-=' : 100},
            }).where(ID);
        } catch (error) {
           return "Error: " +error.toString();
        }
    })

    this.on('largestOrder', async(request,response)=>{
        try {
            const tx = cds.tx(request);

            const response = await tx.read(PurchaseOrderService).orderBy({
                GROSS_AMOUNT : 'desc'
            }).limit(5);

            return response;
        } catch (error) {
            return "Error: " +error.toString();
        }
    })

        this.on('smallestOrder', async(request,response)=>{
        try {
            const tx = cds.tx(request);

            const response = await tx.read(PurchaseOrderService).orderBy({
                GROSS_AMOUNT : 'asc'
            }).limit(5);

            return response;
        } catch (error) {
            return "Error: " +error.toString();
        }
    })

})