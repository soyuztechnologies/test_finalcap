module.exports = cds.service.impl( async function(){

    const { EmployeeSet, POs } = this.entities;

    this.before('UPDATE', EmployeeSet, (req,res)=>{
        if(parseFloat(req.data.salaryAmount) >= 1000000){
            req.error(500, "Salary must be below 1 million");
        }
    });

    this.on('boost', async (req, res) => {
        try {
            console.log(req.params);
            const keyValues = req.params[0];
            console.log("Your purchase order will be boosted haing ID ==> " + keyValues.toString());
            const tx = cds.tx(req);
            try {
                const status = await tx.update(POs).with({
                    GROSS_AMOUNT: { '+=' : 20000 },
                    NOTE: 'Boosted!!'
                }).where(keyValues);
                console.log("After update " + status);
                return {};
            } catch (error) {
                console.log(error.toString());
                console.log(error);
            }
             // await cds.tx(req).run([SELECT.from(POs).where(keyValues)]);
        } catch (error) {
            
        }
    });

    this.on('largestOrder', async (req, res) => {
        try {
            
            const tx = cds.tx(req);
            const reply = await tx.read(POs)
            .orderBy({
                GROSS_AMOUNT: 'asc'
            })
            .limit(1);
            return reply;

            return reply;
        } catch (error) {
            
        }
    });

});