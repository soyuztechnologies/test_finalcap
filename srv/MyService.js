const cds = require('@sap/cds');
const { employees } = cds.entities("anubhav.db.master");

const MyService = function(srv){
    srv.on('somesrv', (req,res) => {
        return "Hey There, welcome to CAPM" ;
    });

    srv.on("READ", "ReadEmployeeSrv", async(req,res) => {
        var results = [];

        //Step 1: just to check if we can replace implementation
        // results.push({
        //     "ID": "01255569-8952-1EIR-ABCD-VV55C1987FV",
        //     "nameFirst": "Chistiano",
        //     "nameLast": "Ronaldo"
        // });

        //CDS Query - CDSQL
        //results = await cds.tx(req).run(SELECT.from(employees).limit(3));

        //Exmaple of where condition
        //results = await cds.tx(req).run(SELECT.from(employees).where({"nameFirst": "Susan"}));

        var whereCondition = req.data;
        console.log(whereCondition);

        if(whereCondition.hasOwnProperty("ID")){
            results = await cds.tx(req).run(SELECT.from(employees).where(whereCondition));
        }else{
            results = await cds.tx(req).run(SELECT.from(employees).limit(3));
        }

        return results;

    });

    srv.on("CREATE", "InsertEmployeeSrv", async (req,res) =>{
        var dataSet = [];

        dataSet.push(req.data[0]);

        console.log(dataSet);

        let returnData = await cds.transaction(req).run([
            INSERT.into(employees).entries([req.data])
        ]).then( (resolve, reject) => {
            if(typeof(resolve) !== undefined){
                return req.data;
            }else{
                req.error(500, "There was an issue in insert");
            }
        }).catch( err => {
            req.error(500, "there was an error " + err.toString());
        });

        return returnData;

    });

    srv.on("UPDATE", "UpdateEmployeeSrv", async (req,res) =>{

        let returnData = await cds.transaction(req).run([
            UPDATE(employees).set({
                nameFirst : req.data.firstName
            }).where({
                ID: req.data.ID
            }),
            UPDATE(employees).set({
                nameLast : req.data.nameLast
            }).where({
                ID: req.data.ID
            })
        ]).then( (resolve, reject) => {
            if(typeof(resolve) !== undefined){
                return req.data;
            }else{
                req.error(500, "There was an issue in update");
            }
        }).catch( err => {
            req.error(500, "there was an error " + err.toString());
        });

        return returnData;

    });

    srv.on("DELETE", "DeleteEmployeeSrv", async (req,res) =>{
        let returnData = await cds.transaction(req).run([
            DELETE.from(employees).where(req.data)
        ]).then( (resolve, reject) => {
            if(typeof(resolve) !== undefined){
                return req.data;
            }else{
                req.error(500, "There was an issue in update");
            }
        }).catch( err => {
            req.error(500, "there was an error " + err.toString());
        });

        return returnData;
    });
}

module.exports = MyService;